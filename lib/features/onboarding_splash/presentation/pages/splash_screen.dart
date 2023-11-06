import 'dart:async';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/constant/images_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import '../../../../core/constant/custom_text_style.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigatorToNextAndNotBack() async {
    bool isBoardingActive =
        locator<CacheHelper>().getData(key: "isOnBoardingActive") ?? false;
    if (isBoardingActive) {
      bool isLoginActive =
          locator<CacheHelper>().getData(key: "isLogin") ?? false;
      if (isLoginActive) {
        bool isEmailVerified =
            await FirebaseAuth.instance.currentUser!.emailVerified;
        if (isEmailVerified) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutesNamed.homePage, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutesNamed.loginScreen, (route) => false);
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesNamed.loginScreen, (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutesNamed.onBoarding, (route) => false);
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), navigatorToNextAndNotBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                image: AssetImage(AppImagesAssets.splach))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: CircleAvatar(
              radius: 100,
              backgroundColor: AppColors.white,
              child: Text(
                "Chat",
                style: CustomTextStyle.pacifico500style35,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
