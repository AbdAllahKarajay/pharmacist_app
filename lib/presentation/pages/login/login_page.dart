import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/util/theme.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../../core/util/palette.dart';
import 'package:flutter/material.dart';

import '../../components/general/state_snack_bar.dart';
import '../../components/general/theme_button.dart';
import 'component/filled_button.dart';
import 'component/unfilled_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  _listener(LoadingStates state){
    // final state = Get.authController.state.value;
    print("listen: $state,");
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
    listener = Get.authController.state.listen((state)=>_listener(state));
  }

  @override
  void dispose() {
    super.dispose();
    listener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController phone = TextEditingController();
    final TextEditingController pass = TextEditingController();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton:
          const SizedBox(width: 80, height: 80, child: ThemeButton()),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              //header
              Text("welcome".tr),
              const Spacer(flex: 1),
              //login
              Flexible(
                flex: 10,
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
                    const SizedBox(height: 80),
                    ColoredFilledButton(
                      color: Theme.of(context).isDark
                          ? ColorConfig.WHITE
                          : ColorConfig.primary,
                      text: "login".tr,
                      secondColor: Theme.of(context).isDark
                          ? ColorConfig.primary
                          : ColorConfig.WHITE,
                      icon: Icons.login,
                      onTap: () {
                        if (Get.authController.state.value !=
                            LoadingStates.loading) {
                          Get.authController.login(
                            phone: phone.text,
                            password: pass.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
