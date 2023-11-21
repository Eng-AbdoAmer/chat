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

///////////Camera State ///////////////
class CameraLoadingState extends HomeState {}

class CameraFailedState extends HomeState {
  final String msg;
  final bool isProfilePathDet;
  CameraFailedState({required this.msg, required this.isProfilePathDet});
}

class CameraSuccessState extends HomeState {
  final String pathImage;
  final bool isProfilePathDet;

  CameraSuccessState({required this.pathImage, required this.isProfilePathDet});
}

/*================= upload image State===============*/
class UploadImageSuccessState extends HomeState {
  final String imageUrl;
  final File file;

  UploadImageSuccessState({
    required this.imageUrl,
    required this.file,
  });
}

class UploadImageFailedState extends HomeState {
  final String msg;

  UploadImageFailedState({required this.msg});
}

class UploadImageLoadingState extends HomeState {
  UploadImageLoadingState();
}
