import 'package:flutter/material.dart';

class CustomTextBody extends StatelessWidget {
  final String body;
  final TextAlign? textAlign;
  const CustomTextBody({Key? key, required this.body, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
