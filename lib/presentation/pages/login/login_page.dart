import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/config/global_data.dart';
import 'package:pharmacist_application/core/util/theme.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';
import 'package:pharmacist_application/presentation/pages/login/signup_page.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../../core/util/palette.dart';
import 'package:flutter/material.dart';

import '../../components/general/state_snack_bar.dart';
import '../../components/general/theme_button.dart';
import 'component/filled_button.dart';
import 'component/unfilled_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.phone}) : super(key: key);
  final String? phone;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  _listener(LoadingStates state){
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

  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    Get.authController.getUser();
    formKey = GlobalKey<FormState>();
    listener = Get.authController.state.listen((state)=>_listener(state));
  }

  @override
  void dispose() {
    super.dispose();
    listener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.globalData.fcmToken);
    final TextEditingController phone = TextEditingController(text: widget.phone);
    final TextEditingController pass = TextEditingController();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton:
          const SizedBox(width: 80, height: 80, child: ThemeButton(text: false,)),
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
                flex: 4,
                child: Form(
                  key: formKey,
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
                              formKey.currentState?.validate();
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
                ),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: (){
                Get.off(const SignupPage());
              }, child: Text("Don't have an account".tr, style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline))),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
