import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmacist_application/presentation/pages/home_page/categories_page/categories_screen.dart';
import 'package:pharmacist_application/presentation/pages/home_page/home_page.dart';

import '../../presentation/pages/login/login_page.dart';
import '../data/models/user.dart';

class GlobalData extends GetxController {
  final GetStorage _box = GetStorage();

  String? fcmToken;

  get isLoggedIn => _user.value != null;

  void init() {
    getUser();
  }

  //user
  final Rx<User?> _user = Rx<User?>(null);

  Rx<User?> get rxUser => _user;
  User get user => _user.value!;
  String get token => _user.value!.token;

  Future<void> setUser(User user) async {
    updateUser(user);
    Get.offAll(()=>const HomePage());
  }

  Future<void> updateUser(User user) async {
    _user.value = user;
    await _box.write("user", _user.value?.toMap());
  }

  Future<void> removeUser() async {
    _user.value = null;
    await _box.remove("user");
    await _box.remove("isAdmin");
    Get.offAll(()=> const LoginPage());
  }

  bool getUser() {
    final userMap = _box.read("user");
    if(userMap != null){
      _user.value = User.fromMap(_box.read("user"));
      return true;
    }
    return false;
  }

  //firstTime
  bool isFirstTime() {
    return _box.read('isFirstTime') ?? false;
  }

  void setFirstTime() async {
    return await _box.write("isFirstTime", true);
  }
}

extension FindGlobalData on GetInterface {
  GlobalData get globalData {
    return Get.find<GlobalData>();
  }
}
