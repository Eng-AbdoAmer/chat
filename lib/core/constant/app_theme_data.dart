import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemeData {
  static TextTheme theme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      height: 2,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.grey,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.grey,
    ),
  );
}
