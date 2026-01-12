import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:tourist_guide_app/presentation/auth/screen/splash_screen.dart';
import 'package:tourist_guide_app/presentation/sights/screen/home_screen.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String signInScreen = '/signIn';
  static const String homeScreen = '/home';

  AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        throw Exception("Route not found...");
    }
  }
}
