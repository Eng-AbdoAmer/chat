import 'package:flutter/material.dart';

import '../../../models/message_model.dart';

class MessageImage extends StatelessWidget {
  //final MessageModel? messages;
  final MessageModel messages;
  final int index;
  const MessageImage({Key? key, required this.messages, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: Image.network(
              messages.imageUrl!,
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}
