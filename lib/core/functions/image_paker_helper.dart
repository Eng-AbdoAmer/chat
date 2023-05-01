import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/message_model.dart';

toTakeImageFromCameraAndSaveAtFireBase(ImageSource imageSource) async {
  XFile? file;
  file = await ImagePicker().pickImage(source: imageSource);
  print(file!.path);
  final mesg = MessageModel(
    messageType: MessageType.image,
    isSender: true,
    messageState: MessageState.viewed,
    imageUrl: file.path,
  );
  final storage = FirebaseStorage.instance;
  final fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  //لفتح ملف الصورا storage و تخزينها
  final ref = storage.ref().child("images").child(file.name);
  await ref.putFile(File(file.path));
  final url = await ref.getDownloadURL();
  print(url);

  ///
  Map<String, dynamic> docment = {
    "image": url,
    "senderId": user?.uid,
    "senderName": user?.displayName,
    "senderImage": user?.photoURL,
    "type": 1,
    "time": DateTime.now(),
  };

  ///add docoment to Firestore
  fireStore.collection("messages").add(docment);
}
