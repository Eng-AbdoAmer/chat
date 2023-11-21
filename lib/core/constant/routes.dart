import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:chat/features/onboarding_splash/presentation/pages/on_boarding_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/register.dart';
import '../../features/home_page/pages/home_page.dart';

class AppRoutesNamed {
  static const String welcome = "/";
  static const String loginScreen = "LoginScreen";
  static const String homePage = "HomePage";
  static const String register = "Register";
  static const String signIn = "signIn";
  static const String onBoarding = "onBoarding";
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutesNamed.welcome:
      //   return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutesNamed.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutesNamed.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutesNamed.register:
        return MaterialPageRoute(builder: (_) => Register());
      case AppRoutesNamed.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
