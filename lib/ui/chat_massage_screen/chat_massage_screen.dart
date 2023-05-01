import 'package:chat/ui/chat_massage_screen/widgets/bulid_sender_message.dart';
import 'package:chat/ui/chat_massage_screen/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/functions/get_data_from_google.dart';

class ChatMassageScreen extends StatefulWidget {
  const ChatMassageScreen({Key? key}) : super(key: key);

  @override
  State<ChatMassageScreen> createState() => _ChatMassageScreenState();
}

class _ChatMassageScreenState extends State<ChatMassageScreen> {
  final messageController = TextEditingController();
  @override
  void initState() {
    messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Massage Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot<Map>>(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .orderBy(
                        "time",
                        descending: false,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    connectionState(snapshot);
                    connectionStateSize(snapshot);
                    checkUserAuth(context);
                    snapshot.data!.docs.forEach((element) {
                      getDataFromGoogle(element, context);
                    });
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          Message(messages: chatMessage[index], index: index),
                      itemCount: chatMessage.length,
                    );
                  }),
            )),
          )),
          BulidSenderMessage(controller: messageController),
        ],
      ),
    );
  }
}
