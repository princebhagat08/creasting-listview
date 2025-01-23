import 'package:flutter/material.dart';
import 'package:youbloomdemo/screens/loginScreen/login_screen.dart';

import 'config/color/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youbloom Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColor.offWhite,
      ),
      home: LoginScreen(),
    );
  }
}


