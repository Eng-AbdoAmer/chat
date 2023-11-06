// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../models/message_model.dart';
// import '../shared/helper_meuthods.dart';

// List<MessageModel> chatMessage = [];
// getDataFromGoogle(QueryDocumentSnapshot<Map<dynamic, dynamic>> element,
//     BuildContext context) async {
//   final data = element.data();
//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     showToast(msg: "not Authentication User", isError: true);
//     Navigator.pop(context);
//   }
//   MessageType type;
//   MessageModel message;
//   final senderId = data['senderId'];
//   if (data["type"] == 1) {
//     type = MessageType.image;
//     message = MessageModel(
//         messageType: type,
//         messageState: MessageState.viewed,
//         isSender: user!.uid == senderId,
//         senderimage: data['senderImage'],
//         sender: data['senderName'],
//         imageUrl: data['image']);
//   } else {
//     type = MessageType.text;
//     message = MessageModel(
//         messageType: type,
//         messageState: MessageState.viewed,
//         isSender: user!.uid == senderId,
//         senderimage: data['senderImage'],
//         sender: data['senderName'],
//         text: data['message']);
//   }
//   chatMessage.add(message);
// }

// connectionState(AsyncSnapshot snapshot) {
//   if (snapshot.connectionState == ConnectionState.waiting) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

// connectionStateSize(AsyncSnapshot snapshot) {
//   if (snapshot.data!.size <= 0) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

// checkUserAuth(BuildContext context) {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     showToast(msg: "not Authentication User", isError: true);
//     Navigator.pop(context);
//   }
// }
