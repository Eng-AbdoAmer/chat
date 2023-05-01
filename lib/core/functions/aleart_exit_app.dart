import 'dart:io';

import 'app_dialoge.dart';

Future<bool> aleartExitApp() {
  appDialog(
      title: "Alert Dialog",
      subtitle: "would you like close this application",
      click: "ok",
      onPressedOKClick: () {
        exit(0);
      });
  return Future.value(true);
}
