part of 'chat_screen_cubit.dart';

abstract class ChatScreenState {}

class ChatScreenInitial extends ChatScreenState {}

class ChatScreenLoadingState extends ChatScreenState {}

class ChatScreenNoMessagesState extends ChatScreenState {}

class ChatScreenFailedState extends ChatScreenState {
  final String msg;

  ChatScreenFailedState({required this.msg});
}

class ChatScreenSuccessState extends ChatScreenState {}

class ChatScreenSuccessGetAllMessageState extends ChatScreenState {
  final List<MessageModel> model;

  ChatScreenSuccessGetAllMessageState({required this.model});
}

