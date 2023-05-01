import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';

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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 50)),
        onPressed: onPressed,
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleLarge,
        ));
  }
}
