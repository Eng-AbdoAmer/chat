part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFailedState extends HomeState {}

class HomeSuccessState extends HomeState {}

///////////Get user ///////////////
class GetUserLoadingState extends HomeState {}

class GetUserFailedState extends HomeState {
  final String msg;

  GetUserFailedState({required this.msg});
}

class GetUserSuccessState extends HomeState {
  final List<UserModel> model;

  GetUserSuccessState({required this.model});
}

/* ==============stories State=============*/
class StoriesSuccessState extends HomeState {
  final List<StoryModel> model;
  StoriesSuccessState({required this.model});
}

class StoriesLoadingState extends HomeState {}
class StoriesAddSuccessState extends HomeState {}

class StoriesFailedState extends HomeState {
  final String msg;

  StoriesFailedState({required this.msg});
}
