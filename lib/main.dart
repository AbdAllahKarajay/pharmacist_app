import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/favorite_page/favorite_controller.dart';
import 'package:pharmacist_application/presentation/pages/search/search_controller.dart';
import 'core/config/config.dart';
import 'core/config/global_data.dart';
import 'package:pharmacist_application/presentation/pages/cart_page/cart_controller.dart';
import 'package:pharmacist_application/presentation/pages/categories_page/categories_controller.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';
import 'package:pharmacist_application/presentation/pages/login/login_page.dart';
import 'package:pharmacist_application/presentation/pages/products_page/products_controller.dart';

import 'core/util/theme.dart';

void main() {
  Get.put(Config());
  Get.put(GlobalData());
  Get.put(AuthController());
  Get.put(CategoriesController());
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
        locale: const Locale('en'),
        theme: ThemeConfig.themeData(false),
        darkTheme: ThemeConfig.themeData(true),
        themeMode: Get.globalConfig.themeMode.value,
        home: const LoginPage(),
      ),
    );
  }
}

class AppTranslations extends Translations {
  static const appNameEn = "AppName";
  static const appNameAr = "اسم التطبيق";

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
        }
      };
}
