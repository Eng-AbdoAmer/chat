import 'package:chat/ui/home_page/home_page.dart';
import 'package:flutter/material.dart';

import '../../ui/auth_page/screens/login.dart';
import '../../ui/auth_page/screens/register.dart';
import '../../ui/welcome_screen.dart';

class AppRoutesNamed {
  static const String welcome = "/";
  static const String loginScreen = "LoginScreen";
  static const String homePage = "HomePage";
  static const String register = "Register";
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNamed.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutesNamed.loginScreen:
        return MaterialPageRoute(builder: (_) => Login());
      case AppRoutesNamed.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutesNamed.register:
        return MaterialPageRoute(builder: (_) => Register());

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
