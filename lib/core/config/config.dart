import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Config extends GetxController {
  //theme
  final Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.system);

  changeThemeMode(ThemeMode newThemeMode) => themeMode.value = newThemeMode;

  //local
  bool get isRTL => Get.locale?.languageCode == 'ar';

}

extension FindConfig on GetInterface {
  Config get globalConfig {
    return Get.find<Config>();
  }
}