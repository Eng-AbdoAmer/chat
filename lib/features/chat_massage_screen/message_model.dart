// import 'package:flutter/cupertino.dart';

// enum MessageType {
//   text,
//   audio,
//   video,
//   image,
// }

// enum MessageState { notSend, notView, viewed }

// class MessageModel {
//   final String text;
//   final MessageType messageType;
//   final MessageState messageState;
//   final bool isSender;
//   final String? senderimage, sender, imageUrl;

//   MessageModel({
//     this.text = "",
//     required this.messageType,
//     required this.messageState,
//     required this.isSender,
//     this.senderimage,
//     this.sender,
//     this.imageUrl,
//   });
// }

// class ChatsMessages with ChangeNotifier {
//   void addMessage(MessageModel model) {
//     chatsMessages.add(model);
//     notifyListeners();
//   }

//   //////////////////////////
//   List<MessageModel> get getMessageList => chatsMessages;
//   //////////////////////////////////////////
//   List<MessageModel> chatsMessages = [
//     MessageModel(
//       text: "Hello Noura",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: true,
//     ),
//     MessageModel(
//       text: "Hello Abdo",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: false,
//     ),
//     MessageModel(
//       text: "How are you?",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: true,
//     ),
//     MessageModel(
//       text: "I am good and you?",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: false,
//     ),
//     MessageModel(
//       text: "Happy to hear that",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: true,
//     ),
//     MessageModel(
//       text: "Nice to meet you Abdo",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: false,
//     ),
//     MessageModel(
//       text: "thanks for calling",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: true,
//     ),
//     MessageModel(
//       text: "you Are Welcome Noura",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: false,
//     ),
//     MessageModel(
//       text: "to yell an to upset to went",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: true,
//     ),
//     MessageModel(
//       text: "every thinks well be okay",
//       messageType: MessageType.text,
//       messageState: MessageState.viewed,
//       isSender: false,
//     ),
//   ];
// }
