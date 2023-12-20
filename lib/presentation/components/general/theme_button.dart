import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/config/config.dart';
import 'package:pharmacist_application/core/util/theme.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 25,
      onPressed: () => Get.globalConfig.changeThemeMode(
          Theme.of(context).isDark ? ThemeMode.light : ThemeMode.dark),
      icon: Obx(
        () => Icon(
          Get.globalConfig.themeMode.value == ThemeMode.dark
              ? Icons.nightlight_outlined
              : Icons.light_mode_outlined,
        ),
      ),
    );
  }
}
