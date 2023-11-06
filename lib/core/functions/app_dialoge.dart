import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../shared/helper_meuthods.dart';

Future<void> appDialog({
  required String title,
  required String subtitle,
  required void Function()? onPressedOKClick,
  required String click,
}) async {
  return showDialog<void>(
    context: navigatorKey.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              //'Would you like to close this app'
              Text(
                subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: onPressedOKClick, child: Text(click)),
          TextButton(
            child: const Text('cansel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
// exit(0); //to close your app

customDialog(
    {required DialogType dialogType,
    required String title,
    required String desc,
    void Function()? btnOkOnPress}) {
  AwesomeDialog(
    dismissOnBackKeyPress: true,
    dismissOnTouchOutside: false,
    context: navigatorKey.currentContext!,
    animType: AnimType.scale,
    dialogType: dialogType,
    title: title,
    desc: desc,
    btnOkOnPress: btnOkOnPress,
  ).show();
}
