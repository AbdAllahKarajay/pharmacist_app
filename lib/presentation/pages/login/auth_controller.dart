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
      User user =
          await RemoteDatasource.instance.performPostRequest<User>("/api/login",
              body: {
                "phone": phone,
                "password": password,
              },
              useToken: false,
              fromMap: User.fromMap);
      // User user = User(token: "token", id: "id", phone: phone);
      state.value = LoadingStates.done;
      Get.globalData.setUser(user);
    } catch (_) {
      state.value = LoadingStates.error;
    }
  }
}

extension FindAuthController on GetInterface {
  AuthController get authController => Get.find<AuthController>();
}
