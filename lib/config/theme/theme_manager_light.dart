import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constant/app_colors.dart';
import '../../core/constant/font_manager.dart';
import '../../core/constant/styles_manager.dart';

ThemeData lightTheme() => ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      primaryColor: AppColors.primaryColor,
      brightness: Brightness.light,
      textTheme: _textTheme(),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
      ),
      appBarTheme: _appBarTheme(),
      popupMenuTheme: _popupMenuThemeData(),
      floatingActionButtonTheme: _floatingActionButtonThemeData(),
      tabBarTheme: tabBarTheme(),
      textButtonTheme: _textButtonThemeData(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      inputDecorationTheme: _inputDecorationTheme(),
      dividerColor: AppColors.grey2,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
    );

BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
  return const BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryColor,
      selectedIconTheme: IconThemeData(color: AppColors.white, size: 25),
      unselectedIconTheme: IconThemeData(color: AppColors.grey2, size: 25));
}

TextTheme _textTheme() {
  return TextTheme(
      displayLarge:
          getBoldStyle(color: AppColors.black, fontSize: FontSize.s28),
      displaySmall:
          getRegularStyle(color: AppColors.grey, fontSize: FontSize.s16),
      displayMedium:
          getMediumStyle(color: AppColors.black, fontSize: FontSize.s20),
      //////////  headline //////////
      headlineLarge:
          getBoldStyle(color: AppColors.grey2, fontSize: FontSize.s28),
      headlineMedium:
          getMediumStyle(color: AppColors.grey2, fontSize: FontSize.s22),
      headlineSmall:
          getRegularStyle(color: AppColors.grey2, fontSize: FontSize.s16),
      ///////////body ///////////////
      bodySmall:
          getRegularStyle(color: AppColors.black, fontSize: FontSize.s16),
      bodyMedium: getMediumStyle(color: AppColors.grey, fontSize: FontSize.s22),
      bodyLarge: getLightStyle(color: AppColors.grey, fontSize: FontSize.s28),
      /////////////label/////////////
      labelLarge:
          getBoldStyle(color: AppColors.primaryColor, fontSize: FontSize.s28),
      labelMedium:
          getMediumStyle(color: AppColors.primaryColor, fontSize: FontSize.s22),
      labelSmall: getRegularStyle(
          color: AppColors.primaryColor, fontSize: FontSize.s16),
      //////////title////////////////
      titleLarge: getBoldStyle(color: AppColors.black, fontSize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: AppColors.black, fontSize: FontSize.s22),
      titleSmall:
          getSemiBoldStyle(color: AppColors.black, fontSize: FontSize.s28));
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    color: AppColors.primaryColor,
    centerTitle: true,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: AppColors.primaryColor,
      fontSize: FontSize.s20,
      fontWeight: FontWeightManager.semiBold,
    ),
    iconTheme: IconThemeData(color: AppColors.black),
    actionsIconTheme: IconThemeData(
      color: AppColors.black,
      size: FontSize.s26,
    ),
  );
}

TabBarTheme tabBarTheme() {
  return const TabBarTheme(
    labelStyle: TextStyle(
      color: AppColors.white,
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.bold,
    ),
  );
}

TextButtonThemeData _textButtonThemeData() {
  return TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle:
              getMediumStyle(color: AppColors.black, fontSize: FontSize.s22)));
}

PopupMenuThemeData _popupMenuThemeData() {
  return PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      textStyle:
          getMediumStyle(color: AppColors.black, fontSize: FontSize.s22));
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
      errorMaxLines: 1,
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(25.7),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(25.7),
      ),
      counterStyle:
          getMediumStyle(color: AppColors.black, fontSize: FontSize.s17),
      hintStyle:
          const TextStyle(color: AppColors.grey2, fontSize: FontSize.s12),
      labelStyle: getRegularStyle(
          color: AppColors.primaryColor, fontSize: FontSize.s17),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.black),
        borderRadius: BorderRadius.circular(25.7),
      ),
      border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))));
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      textStyle: getMediumStyle(color: AppColors.white, fontSize: FontSize.s22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      minimumSize: const Size(double.infinity, 50),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
    ),
  );
}

FloatingActionButtonThemeData _floatingActionButtonThemeData() {
  return const FloatingActionButtonThemeData(
      elevation: 0, backgroundColor: AppColors.primaryColor);
}
