import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/description_bloc/description_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/config/routes/routes.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/data/network/network_api_services.dart';
import 'package:youbloomdemo/repository/login_repo/login_repository.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_options.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_services.dart';
import 'package:youbloomdemo/services/session_manager/check_session.dart';

import 'config/color/color.dart';

void main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => DescriptionBloc()),
      ],
      child: MaterialApp(
        title: 'Youbloom Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColor.offWhite,
        ),
        initialRoute: RoutesName.login, // Initial route
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
