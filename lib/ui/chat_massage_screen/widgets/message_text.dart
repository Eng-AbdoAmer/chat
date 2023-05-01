import 'package:chat/core/constant/colors.dart';
import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageText extends StatelessWidget {
  const MessageText({Key? key, required this.messages}) : super(key: key);
  final MessageModel messages;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !(messages.isSender)
              ? Text(
                  messages.sender ?? "@Abdo Amer@",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                )
              : const SizedBox(
                  height: 3,
                ),
          Text(
            messages.text,
            style: TextStyle(
              color: messages.isSender ? AppColors.white : AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
