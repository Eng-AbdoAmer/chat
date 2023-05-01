import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

sendTextToGoogle(TextEditingController controller) async {
  final user = FirebaseAuth.instance.currentUser;
  final message = controller.text;
  //print(message);
  final Map<String, dynamic> messageDoc = {
    "message": message,
    "id": user!.uid,
    "sender": user.displayName,
    "time": DateTime.now(),
  };
  final docoment =
      await FirebaseFirestore.instance.collection("messages").add(messageDoc);
  // print(docoment.path);
  //print(docoment.id);
  controller.clear();
}
