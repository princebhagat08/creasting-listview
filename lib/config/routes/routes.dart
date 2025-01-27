import 'package:flutter/material.dart';
import 'package:youbloomdemo/config/routes/custom_page_route.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/screens/description_screen/description_screen.dart';
import 'package:youbloomdemo/screens/homeScreen/home_screen.dart';
import 'package:youbloomdemo/screens/loginScreen/login_screen.dart';
import 'package:youbloomdemo/screens/loginScreen/otp_screen.dart';
import 'package:youbloomdemo/screens/splash_screen/splash_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.otp:
        return MaterialPageRoute(
            builder: (BuildContext context) => OtpScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.productDescription:
        final product = settings.arguments as Products;
        return CustomPageRoute(page: DescriptionScreen(product: product));

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
