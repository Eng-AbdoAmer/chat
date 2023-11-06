import 'package:flutter/Material.dart';

import 'app_colors.dart';
import 'font_manager.dart';

abstract class CustomTextStyle {
  static const pacifico500style24 = TextStyle(
      fontSize: FontSize.s24,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: "Pacifico");
  static const pacifico500style35 = TextStyle(
      fontSize: 80,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor,
      fontFamily: "Pacifico");
  static const pacifico500style35Whit = TextStyle(
      fontSize: 80,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      fontFamily: "Pacifico");
}
