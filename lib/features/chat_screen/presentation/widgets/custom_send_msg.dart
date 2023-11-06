import 'package:flutter/Material.dart';

import '../../../../core/constant/app_colors.dart';

class CustomSendMsg extends StatelessWidget {
  final String msg;
  const CustomSendMsg({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.grey2.withOpacity(0.5),
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            )),
        child: Text(msg),
      ),
    );
  }
}
