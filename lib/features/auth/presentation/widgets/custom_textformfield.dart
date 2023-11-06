import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String?)? onSaved;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final IconData? icon;
  final void Function()? onPressedIconButton;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    Key? key,
    this.onSaved,
    this.label,
    required this.obscureText,
    this.hintText,
    this.icon,
    this.validator,
    this.onPressedIconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onSaved: onSaved,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(label!),
            hintText: hintText,
            suffixIcon:
                IconButton(onPressed: onPressedIconButton, icon: Icon(icon)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
  }
}
