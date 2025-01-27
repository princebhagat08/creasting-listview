import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/description_bloc/description_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_bloc.dart';
import 'package:youbloomdemo/bloc/language_bloc/language_state.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/config/internationalization/language.dart';
import 'package:youbloomdemo/config/routes/routes.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_options.dart';
import 'bloc/language_bloc/language_bloc.dart';

import 'config/color/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( BlocProvider(
  create: (context) => LanguageBloc(),
  child: MyApp(),
  ),);
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
        BlocProvider(create: (_) => LanguageBloc()),
      ],
      child: MaterialApp(
        title: 'Youbloom Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColor.offWhite,
        ),
        initialRoute: RoutesName.splash, // Initial route
        onGenerateRoute: Routes.generateRoute,
        locale: Locale(Language.getCurrentLanguage(context)),
      ),

    );
  }
}
