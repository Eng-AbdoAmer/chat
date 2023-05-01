import 'package:flutter/material.dart';

//TODO: must be put navigatorKey in main under MaterialApp
final navigatorKey = GlobalKey<NavigatorState>();
//////////////////////////////////////////////////////////////
Future navigateTo({required page, withHistory = true}) {
  return Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => page), (route) => withHistory);
}

showToast({required String msg, Color? backgroundColor}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: backgroundColor,
  ));
}

// space({double? h, double? w, Widget? ch}) {
//   return SizedBox(
//     height: h,
//     width: w,
//     child: ch,
//   );
// }
