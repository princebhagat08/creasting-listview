import 'package:flutter/material.dart';
import 'package:youbloomdemo/config/color/color.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';
import 'package:youbloomdemo/services/splash_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{
  final SplashServices splashServices = SplashServices();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
    splashServices.checkAuthentication(context);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
        height: mq.height,
        width: mq.width,
        color: AppColor.primaryColor.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ScaleTransition(
              scale: _animation,
              child: Text('Demo Splash',style: xLargeWhiteText,),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
