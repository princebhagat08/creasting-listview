import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/services/session_manager/session_controller.dart';

class SplashServices {

  void checkAuthentication(BuildContext context) async {
    SessionController().getUserFromPreference().then((value) async {
      if (SessionController.isLogin ?? false) {
        Timer(
          const Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
        );
      }
    }).onError((error, stackTrace) {
      Timer(
        const Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
      );
    });
  }
}