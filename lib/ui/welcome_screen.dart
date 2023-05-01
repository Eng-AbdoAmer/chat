import 'package:chat/core/constant/app_strings.dart';
import 'package:chat/core/constant/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/constant/images_assets.dart';
import '../core/functions/custom_sizebox.dart';
import '../firebase_options.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutesNamed.loginScreen, (route) => false);
        },
        icon: const Icon(Icons.arrow_forward_ios),
        label: const Text(AppString.skip),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Lottie.asset(AppImagesAssets.welcomeChat,
                height: 400, width: double.infinity),
            space(15, 0),
            const Text(AppString.welcomeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            space(15, 0),
            const Text(
              AppString.welcomeSubTitle,
              textAlign: TextAlign.center,
            ),
            const Text(
              AppString.welcomeBody,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
