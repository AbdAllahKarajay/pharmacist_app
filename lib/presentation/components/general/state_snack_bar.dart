import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';

mixin StateSnackBar {
  void stateSnackBar({
    required LoadingStates state,
    required String loadingMessage,
    required String errorMessage,
    required String doneMessage,
    required Function onDone,
  }) {
    stateSnackBars(
        state: state,
        loadingMessage: loadingMessage,
        errorMessage: errorMessage,
        doneMessage: doneMessage,
        onDone: onDone);
  }

  static void stateSnackBars({
    required LoadingStates state,
    required String loadingMessage,
    required String errorMessage,
    required String doneMessage,
    required Function onDone,
  }) {
    if (state == LoadingStates.loading) {
      // Get.closeAllSnackbars();
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(milliseconds: 1500),
        borderColor: Colors.grey,
        title: "loading".tr,
        message: loadingMessage,
      ));
      // Timer(const Duration(milliseconds: 1500), () => Get.closeCurrentSnackbar());
    } else if (state == LoadingStates.error) {
      // Get.closeAllSnackbars();
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(milliseconds: 1500),
        borderColor: Colors.red,
        title: "error".tr,
        message: errorMessage,
      ));
      // Timer(const Duration(milliseconds: 1500), () => Get.closeCurrentSnackbar());
    } else if (state == LoadingStates.done) {
      // Get.closeAllSnackbars();
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(milliseconds: 1500),
        borderColor: Colors.green,
        // title: "done".tr,
        message: doneMessage,
      ));
      // Timer(const Duration(milliseconds: 1500), () => Get.closeCurrentSnackbar());
      onDone();
    }
  }
}
