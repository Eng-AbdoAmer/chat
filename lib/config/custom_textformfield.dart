import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';
import '../core/constant/font_manager.dart';
import '../core/constant/styles_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String?)? onSaved;
  final String? label;
  final String? initialValue;
  final String? hintText;
  final bool obscureText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final void Function()? onPressedIconButton;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;

  final TextEditingController? controller;
  const CustomTextFormField({
    Key? key,
    this.onSaved,
    this.label,
    this.obscureText = false,
    this.hintText,
    this.icon,
    this.validator,
    this.onPressedIconButton,
    this.keyboardType,
    this.initialValue,
    this.onTap,
    this.readOnly = false,
    this.controller,
    this.maxLines = 1,
    this.onChanged,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        maxLines: maxLines,
        controller: controller,
        readOnly: readOnly,
        onSaved: onSaved,
        onTap: onTap,
        initialValue: initialValue,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        style: getRegularStyle(color: AppColors.black, fontSize: FontSize.s14),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.grey2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.grey2)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label ?? ""),
            hintText: hintText,
            suffixIcon:
                IconButton(onPressed: onPressedIconButton, icon: Icon(icon)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));
  }
}
