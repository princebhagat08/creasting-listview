import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:youbloomdemo/model/login_model.dart';
import '../storage/local_storage.dart';

class SessionController {

  final LocalStorage sharedPreferenceClass = LocalStorage();

  static final SessionController _session = SessionController._internal();

  static bool? isLogin;

  static LoginModel tokens = LoginModel();


  SessionController._internal() {
    isLogin = false;
  }


  factory SessionController() {
    return _session;
  }


  Future<void> saveUserInPreference(dynamic user) async {
    sharedPreferenceClass.setValue('access_token', jsonEncode(user));
    sharedPreferenceClass.setValue('isLogin', 'true');
  }


  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('access_token');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');

      if (userData.isNotEmpty) {
        SessionController.tokens = LoginModel.fromJson(jsonDecode(userData));
      }
      SessionController.isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
