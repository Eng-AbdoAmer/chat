import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';

import 'message_image.dart';
import 'message_text.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.messages,
    required this.index,
  }) : super(key: key);

  final MessageModel messages;
  final int index;
  @override
  Widget build(BuildContext context) {
    Widget messageContain(MessageModel messages, int index) {
      switch (messages.messageType) {
        case MessageType.text:
          return MessageText(messages: messages);
        case MessageType.image:
          return MessageImage(messages: messages, index: index);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: messages.isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            messageContain(messages, index),
          ],
        ),
      ),
    );
  }
}
