import 'package:flutter/material.dart';
import 'package:youbloomdemo/screens/homeScreen/home_screen.dart';
import 'package:youbloomdemo/screens/loginScreen/login_screen.dart';
import 'package:youbloomdemo/screens/loginScreen/otp_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.otp:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (BuildContext context) => OtpScreen(
                  verificationId: verificationId,
                ));

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
