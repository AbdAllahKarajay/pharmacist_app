import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/config/global_data.dart';
import 'package:pharmacist_application/core/util/theme.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';
import 'package:pharmacist_application/presentation/pages/login/login_page.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../../core/util/palette.dart';
import 'package:flutter/material.dart';

import '../../components/general/state_snack_bar.dart';
import '../../components/general/theme_button.dart';
import 'component/filled_button.dart';
import 'component/unfilled_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  _listener(LoadingStates state) {
    // final state = Get.authController.state.value;
    if (kDebugMode) {
      print("listen: $state,");
    }
    StateSnackBar.stateSnackBars(
        state: state,
        loadingMessage: "trying_login".tr,
        errorMessage: "error_login".tr,
        doneMessage: "done_login".tr,
        onDone: () {});
  }

  StreamSubscription<LoadingStates>? listener;

  @override
  void initState() {
    super.initState();
    Get.authController.getUser();
    listener = Get.authController.state.listen((state) => _listener(state));
  }

  @override
  void dispose() {
    super.dispose();
    listener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.globalData.fcmToken);
    final TextEditingController phone = TextEditingController();
    final TextEditingController pass = TextEditingController();
    final TextEditingController name = TextEditingController();
    final TextEditingController location = TextEditingController();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: const SizedBox(
          width: 80,
          height: 80,
          child: ThemeButton(
            text: false,
          )),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //header
              const Spacer(flex: 1),
              Text("welcome".tr),
              const Spacer(flex: 1),
              // Flexible(flex: 2, child: Center(child: Image.asset("assets/logo_trans.png"),),),
              const Spacer(flex: 2),
              const Spacer(flex: 1),
              //login
              Flexible(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UnfilledTextField(
                        controller: phone,
                        color: Theme.of(context).isDark
                            ? ColorConfig.WHITE
                            : ColorConfig.primary,
                        hintText: "phone".tr,
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          //TODO: number formatters
                        ],
                      ),
                      const SizedBox(height: 20),
                      UnfilledTextField(
                        obscure: true,
                        controller: pass,
                        color: Theme.of(context).isDark
                            ? ColorConfig.WHITE
                            : ColorConfig.primary,
                        hintText: "password".tr,
                        icon: Icons.password,
                        // inputFormatters: [
                        //   //TODO: password formatters
                        // ],
                      ),
                      const SizedBox(height: 20),
                      UnfilledTextField(
                        controller: name,
                        color: Theme.of(context).isDark
                            ? ColorConfig.WHITE
                            : ColorConfig.primary,
                        hintText: "name".tr,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      UnfilledTextField(
                        controller: location,
                        color: Theme.of(context).isDark
                            ? ColorConfig.WHITE
                            : ColorConfig.primary,
                        hintText: "location".tr,
                        icon: Icons.house,
                      ),
                      const SizedBox(height: 40),
                      ColoredFilledButton(
                        color: Theme.of(context).isDark
                            ? ColorConfig.WHITE
                            : ColorConfig.primary,
                        text: "signup".tr,
                        secondColor: Theme.of(context).isDark
                            ? ColorConfig.primary
                            : ColorConfig.WHITE,
                        icon: Icons.login,
                        onTap: () async {
                          print(Get.authController.state.value);
                          if (Get.authController.state.value !=
                              LoadingStates.loading) {
                            try {
                              await Get.authController.signup(
                                phone: phone.text,
                                password: pass.text,
                                name: name.text,
                                location: location.text,
                              );
                              Get.off(LoginPage(
                                phone: phone.text,
                              ));
                            } catch (_) {}
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.off(const LoginPage());
                },
                child: Text(
                  "have_account".tr,
                  style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
