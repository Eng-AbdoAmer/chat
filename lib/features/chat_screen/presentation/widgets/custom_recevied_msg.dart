import 'package:chat/features/chat_screen/data/models/message_model.dart';
import 'package:flutter/Material.dart';

import '../../../../core/constant/app_colors.dart';

class CustomReceviedMsg extends StatelessWidget {
  final MessageModel model;
  final String recevedId;
  const CustomReceviedMsg(
      {Key? key, required this.model, required this.recevedId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: recevedId == model.receiverId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: recevedId == model.receiverId
                ? AppColors.primaryColor.withOpacity(0.5)
                : AppColors.grey2.withOpacity(0.5),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            )),
        child: Text(model.text!),
      ),
    );
  }
}
