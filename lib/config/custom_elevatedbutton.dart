import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';
import '../core/constant/font_manager.dart';
import '../core/constant/styles_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const CustomElevatedButton({Key? key, required this.name, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(double.infinity, 60)),
        onPressed: onPressed,
        child: Text(
          name,
          style: getBoldStyle(color: AppColors.white, fontSize: FontSize.s20),
        ));
  }
}
