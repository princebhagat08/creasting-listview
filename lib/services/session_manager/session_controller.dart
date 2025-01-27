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

  Future<void> saveUserInPreference(LoginModel user) async {
    sharedPreferenceClass.setValue('token', user.accessToken!);
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('token');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');

      if (userData.isNotEmpty) {
        SessionController.tokens = LoginModel(
          accessToken: userData,
        );
      }
      SessionController.isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> eraseUserData() async {
    await sharedPreferenceClass.clear('token');
    await sharedPreferenceClass.clear('isLogin');
    SessionController.isLogin = false;
  }
}
