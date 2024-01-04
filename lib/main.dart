import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/favorite_page/favorite_controller.dart';
import 'package:pharmacist_application/presentation/pages/home_page/order_page/order_controller.dart';
import 'package:pharmacist_application/presentation/pages/search/search_controller.dart';
import 'core/config/config.dart';
import 'core/config/global_data.dart';
import 'package:pharmacist_application/presentation/pages/cart_page/cart_controller.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';
import 'package:pharmacist_application/presentation/pages/login/login_page.dart';
import 'package:pharmacist_application/presentation/pages/products_page/products_controller.dart';

import 'core/util/firebase_messaging.dart';
import 'core/util/theme.dart';
import 'firebase_options.dart';
import 'presentation/pages/home_page/categories_page/categories_controller.dart';

init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.globalData.fcmToken = await FirebaseMessaging.instance.getToken();
  NotificationSettings notificationSettings;
  // do {
    notificationSettings = await FirebaseMessaging.instance
        .requestPermission(sound: true, alert: true);
  // }while(notificationSettings.authorizationStatus != AuthorizationStatus.authorized);
  print(notificationSettings.authorizationStatus);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) => firebaseMessagingBackgroundHandler(event));
  FirebaseMessaging.onMessageOpenedApp.listen(firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessageOpenedApp.listen(firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  Get.put(Config());
  Get.put(GlobalData());
  Get.put(AuthController());
  Get.put(CategoriesController());
  Get.put(OrderController());
  Get.put(ProductsController());
  Get.put(CartController());
  Get.put(FavoriteController());
  Get.put(SearchGetController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        translations: AppTranslations(),
        scrollBehavior: MyCustomScrollDevices(),
        locale: Get.locale,
        theme: ThemeConfig.themeData(false),
        darkTheme: ThemeConfig.themeData(true),
        themeMode: Get.globalConfig.themeMode.value,
        home: const LoginPage(),
      ),
    );
  }
}

class MyCustomScrollDevices extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {...super.dragDevices, PointerDeviceKind.mouse};
}

class AppTranslations extends Translations {
  static const appNameEn = "Mangerug";
  static const appNameAr = "مانجيروغ";

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          "appName": appNameEn,
          "search": "Search",
          'no_results': 'Your search has no results',
          'currency': 'S.P',
          'login_message': 'Login: Enter Your Account Details',
          'phone': "Phone",
          'password': 'Password',
          'loading': 'Loading',
          'error': 'Error',
          'trying_login': 'Trying To Login',
          'error_login': 'Login Failed',
          'done_login': 'Login Successful',
          'welcome': 'Welcome To $appNameEn',
          'S.P': 'S.P',
          'cart': 'Cart',
          'price': 'Price',
          'commercial_name': 'Commercial Name',
          'scientific_name': 'Scientific Name',
          'favorites': 'Favorites',
          'category': 'Category',
          'company': 'Company',
          'search_by': 'Search By',
          'medicine_name': 'Medicine Name',
          'send': 'send',
          'settings': 'Settings',
          'my_orders': 'My Orders',
          'products': 'Products',
          'paid': 'Paid',
          'unpaid': 'Unpaid',
          'signup': 'Signup',
          'no_more': 'No More',
          'search for category': 'Search For Category',
          'total_price': 'Total Price',
          'logout': 'Logout',
          'dark': 'Dark Mode',
          'dont_have_account': "Don't Have Account",
          'have_account': "Have Account",
        },
        'ar': {
          "appName": appNameAr,
          "search": "بحث",
          'no_results': 'لا يوجد نتائج لبحثك',
          'currency': 'ل.س',
          'login_message': 'أدخل معلومات حسابك لتسجيل الدخول',
          'phone': 'رقم الجوال',
          'password': 'كلمة المرور',
          'loading': 'جاري التحميل',
          'error': 'حدث خطأ',
          'trying_login': 'يتم الآن تسجيل الدخول',
          'error_login': 'فشل تسجيل الدخول',
          'done_login': 'تم تسحيل الدخول',
          'welcome': 'أهلا بك في $appNameAr',
          'S.P': 'ل.س',
          'cart': 'سلة المنتجات',
          'price': 'السعر',
          'commercial_name': 'الاسم التجاري',
          'scientific_name': 'الاسم العلمي',
          'favorites': 'المفضلة',
          'category': 'الصنف',
          'company': 'الشركة',
          'search_by': 'البحث حسب',
          'medicine_name': 'اسم الدواء',
          'send': 'ارسال',
          'settings': 'اعدادات',
          'my_orders': 'طلباتي',
          'products': 'المنتجات',
          'paid': 'مدفوع',
          'unpaid': 'غير مدفوع',
          'no_more': 'لا يوجد مزيد',
          'signup': 'إنشاء حساب',
          'search for category': 'بحث عن صنف',
          'total_price': 'السعر الكلي',
          'logout': 'تسجيل الخروج',
          'dark': 'الوضع الليلي',
          'dont_have_account': "ليس لديك حساب",
          'have_account': "لديك حساب مسبقاً",
        }
      };
}
