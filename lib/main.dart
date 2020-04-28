import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterapp/simple_bloc_delegate.dart';
import 'package:flutterapp/splash_screen.dart';
import 'package:flutterapp/user_repository.dart';

import 'authentication_bloc/authentication_bloc.dart';
import 'common/screen_util.dart';
import 'home/home_screen.dart';
import 'signin/signin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final Dio dio = Dio(BaseOptions(receiveTimeout: 5000, connectTimeout: 5000));

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
        dio: dio,
      )..add(AppStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ko'),
      ],
      theme: ThemeData(
        primaryColor: Color(0xFFFF9600),
        primaryColorLight: Color(0xFFFF9600),
        accentColor: Color(0xFFFF9600),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          ScreenUtil.instance = ScreenUtil()..init(context);
          if (state is Unauthenticated) {
            return HomeScreen();
          }
          if (state is Authenticated) {
            return HomeScreen();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
