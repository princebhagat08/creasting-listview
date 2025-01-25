import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/config/routes/routes.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_options.dart';
import 'package:youbloomdemo/services/session_manager/check_session.dart';

import 'config/color/color.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>LoginBloc(),
      child: MaterialApp(
        title: 'Youbloom Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColor.offWhite,
        ),
        initialRoute: RoutesName.home, // Initial route
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


