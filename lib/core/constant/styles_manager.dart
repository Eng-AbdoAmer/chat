import 'package:flutter/material.dart';

import '../../core/constant/font_manager.dart';

TextStyle getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    // fontFamily: FontConstants.fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// regular style
TextStyle getRegularStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
  );
}

// medium style
TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
  );
}

// medium style
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return getTextStyle(
    fontSize,
    FontWeightManager.light,
    color,
  );
}

// bold style
TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
  );
}

// semibold style
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s24,
  required Color color,
}) {
  return getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
  );
}
