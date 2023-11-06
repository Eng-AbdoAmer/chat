import 'package:chat/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

//TODO: must be put navigatorKey in main under MaterialApp
final navigatorKey = GlobalKey<NavigatorState>();
//////////////////////////////////////////////////////////////
Future navigateTo({required page, withHistory = true}) {
  return Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => page), (route) => withHistory);
}

showToast({required String msg, bool isError = true}) {
  // bool isError = false;
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
    content:
        Text(msg, style: const TextStyle(color: AppColors.white, fontSize: 18)),
    backgroundColor: isError ? AppColors.red : AppColors.green,
  ));
}

// space({double? h, double? w, Widget? ch}) {
//   return SizedBox(
//     height: h,
//     width: w,
//     child: ch,
//   );
// }
