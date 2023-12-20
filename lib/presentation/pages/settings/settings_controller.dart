import 'package:get/get.dart';

class SettingsController extends GetxController{

}

extension FindAuthController on GetInterface{
  SettingsController get settingsController => Get.find<SettingsController>();
}