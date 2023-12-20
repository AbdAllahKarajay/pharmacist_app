import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/util/theme.dart';
import 'package:pharmacist_application/presentation/components/appBar/home_app_bar.dart';
import 'package:pharmacist_application/presentation/pages/login/auth_controller.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../../core/util/palette.dart';
import 'package:flutter/material.dart';

import '../../components/general/theme_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(),
    );
  }
}