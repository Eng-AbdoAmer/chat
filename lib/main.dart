import 'package:chat/core/constant/routes.dart';
import 'package:chat/ui/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'core/shared/helper_meuthods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutesNamed.welcome,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}
