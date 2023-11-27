import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHelpers {
  static confrimAwesomeDialog(
      {required BuildContext context,
      required String btnOkText,
      required String btnCancelText,
      required Function btnOkOnPress,
      String? text}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body:
          Image.asset("assets/images/logo.png", height: 150, fit: BoxFit.cover),
      btnOkText: btnOkText,
      btnOkColor: AppColors.primaryColor,
      btnOkOnPress: () async {
        btnOkOnPress();
      },
      btnCancelText: btnCancelText,
      btnCancelColor: Colors.redAccent,
      btnCancelOnPress: () {},
    ).show();
  }

  static closeAppDialog(BuildContext context) {
    confrimAwesomeDialog(
        context: context,
        btnOkText: "أغلق",
        btnCancelText: "لا",
        btnOkOnPress: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        });
  }

  // //show snack bar
  // static showSnackBar(String message, String status) {
  //   ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
  //    // status == "error" ? 'Error' : 'تنبيه',
  //    // message,
  //     // snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: status == "error" ? AppColors.red : AppColors.green,
  //    // borderRadius: 10,
  //     margin: const EdgeInsets.all(15),
  //    // colorText: AppColors.white,
  //     duration: const Duration(seconds: 4),
  //   //  isDismissible: true,
  //     dismissDirection: DismissDirection.horizontal,
  //    // forwardAnimationCurve: Curves.easeOutBack,
  //   ));
  // }
}
