import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final void Function()? onPressed;
  final String? title, subTitle;
  const CustomRow({Key? key, this.onPressed, this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title!),
        TextButton(
          onPressed: onPressed,
          child: Text(
            subTitle!,
          ),
        ),
      ],
    );
  }
}
