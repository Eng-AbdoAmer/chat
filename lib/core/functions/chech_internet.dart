import 'dart:io';

import 'package:flutter/material.dart';

import '../shared/helper_meuthods.dart';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("true");
      return true;
    }
  } on SocketException catch (e) {
    showToast(msg: "Error try again  later +$e", isError: true);
    return false;
  }
}
