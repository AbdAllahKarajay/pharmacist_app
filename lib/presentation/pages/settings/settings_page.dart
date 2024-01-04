
import 'package:get/get.dart';
import 'package:pharmacist_application/core/config/config.dart';

import 'package:flutter/material.dart';
import 'package:pharmacist_application/core/util/theme.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';

import '../../components/general/theme_button.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
      children: [
        const SizedBox(height: 20),
        SwitchListTile(title: Text("dark".tr), value: Theme.of(context).isDark , onChanged: (value){
        Get.globalConfig.changeThemeMode(
            value ? ThemeMode.dark : ThemeMode.light);
          }),
        const SizedBox(height: 20),
        SwitchListTile(title: Text(Get.locale?.languageCode == 'ar'
          ? "عربي" : "English"), value: Get.locale?.languageCode == 'ar' , onChanged: (value){
        print(Get.locale);
        Get.updateLocale(Get.locale?.languageCode == 'ar'? const Locale('en') : const Locale('ar'));
        print(Get.locale);
          }),
        const Spacer(),
        ListTile(title: Text("logout".tr), onTap: () => Get.authController.logout(),),
        const SizedBox(height: 20),
      ],
        ),
    );
  }
}
