import 'package:chat/core/services/cache_helper.dart';
import 'package:chat/core/services/locator.dart';
import 'package:chat/features/chat_screen/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/app-links.dart';
part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  ChatScreenCubit() : super(ChatScreenInitial());
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//Users
  TextEditingController message = TextEditingController();
  String senderId = locator<CacheHelper>().getData(key: "AccountEmail");

  Future<dynamic> sendNotification(
      {required String token,
      required String title,
      required String body}) async {
    try {
      Response response = await Dio().post(AppLinks.notificationApi,
          options: Options(headers: AppLinks.myHeadersToNotification),
          data: {
            "to": token,
            "notification": {"title": title, "body": body},
            "priority": "high",
            "data": {
              "hello": "hello",
              "click_action": "FLUTTER_NOTIFICATION_CLICK"
            },
            'topic': 'all', // Send to the 'all' topic to target all users
          });
      print(response.data);
      return response.data;
    } on DioException catch (ex) {
      return ex.message;
    }
  }

  ///////////////////////////

  Future<void> addMessage({required String receiverId}) async {
    messagesList = [];
    try {
      emit(ChatScreenAddLoadingState());
      final String massage = message.text.trim();
      MessageModel model = MessageModel(
        dateTime: DateTime.now().toString(),
        receiverId: receiverId,
        senderId: senderId,
        text: massage,
      );
      fireStore
          .collection("Users")
          .doc(senderId)
          .collection("chats")
          .doc(receiverId)
          .collection("messages")
          .add(model.toJson())
          .then((value) {
        emit(ChatScreenSuccessState());
      }).catchError((e) {
        emit(ChatScreenFailedState(msg: e.toString()));
      });
      //send message to send and receved
      fireStore
          .collection("Users")
          .doc(receiverId)
          .collection("chats")
          .doc(senderId)
          .collection("messages")
          .add(model.toJson())
          .then((value) {
        emit(ChatScreenSuccessState());
        message.clear();
      }).catchError((e) {
        emit(ChatScreenFailedState(msg: e.toString()));
      });

      emit(ChatScreenSuccessState());
      //String token = locator<CacheHelper>().getData(key: "token");

      print('Message added successfully.');
    } catch (e) {
      emit(ChatScreenFailedState(msg: e.toString()));
      // snackBar(false);
      print('Error adding message: $e');
    }
  }

  List<MessageModel> messagesList = [];
  void getAllMessage({required String receiverId}) async {
    emit(ChatScreenLoadingState());
    try {
      fireStore
          .collection("Users")
          .doc(receiverId)
          .collection("chats")
          .doc(senderId)
          .collection("messages")
          .orderBy("dateTime")
          .snapshots()
          .listen((event) {
        if (event.docs.isEmpty) {
          print("messageslength zero");
          emit(ChatScreenNoMessagesState());
        } else {
          messagesList = [];
          event.docs.forEach((element) {
            messagesList.add(MessageModel.fromJson(element.data()));
            print(messagesList.toString());
            emit(ChatScreenSuccessGetAllMessageState(model: messagesList));
          });
        }
      });
    } catch (err) {
      emit(ChatScreenFailedState(msg: err.toString()));
      print(err.toString());
    }
  }
}
