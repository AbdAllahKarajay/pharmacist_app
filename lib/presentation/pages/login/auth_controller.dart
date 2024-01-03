import 'package:get/get.dart';
import 'package:pharmacist_application/core/config/global_data.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';

import '../../../core/data/models/user.dart';
import '../../../core/repository/remote_datasource.dart';

class AuthController extends GetxController {
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;

  Future<void> login({required String phone, required String password}) async {
    state.value = LoadingStates.loading;
    try {
      User user = await RemoteDatasource.instance.performPostRequest<User>(
        "/api/login",
        body: {
          "phone": phone,
          "password": password,
        },
        useToken: false,
        fromMap: User.fromMap,
      );
      Get.globalData.setUser(user);
      try {
        await setToken();
        state.value = LoadingStates.done;
      } catch (e) {
        Get.globalData.removeUser();
      }
    } catch (_) {
      state.value = LoadingStates.error;
    }
  }

  void getUser() {
    state.value = LoadingStates.loading;
    if (Get.globalData.getUser()) {
      state.value = LoadingStates.done;
    } else {
      state.value = LoadingStates.nothing;
    }
  }

  Future<void> setToken() async {
    await RemoteDatasource.instance.performPostRequest(
      "/api/set_device_token/${Get.globalData.fcmToken}",
    );
  }

  logout() {
    Get.globalData.removeUser();
  }
}

extension FindAuthController on GetInterface {
  AuthController get authController => Get.find<AuthController>();
}
