part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailedState extends AuthState {}

class AuthSuccessState extends AuthState {}

//////////////Login State////////////
class LoginLoadingState extends AuthState {}

class LoginFailedState extends AuthState {
  final String msg;

  LoginFailedState({required this.msg});
}

class LoginSuccessState extends AuthState {}

//////////////SignIn State////////////
class SignInLoadingState extends AuthState {}

class SignInFailedState extends AuthState {}

class SignInSuccessState extends AuthState {}

//////////////Register State////////////
class RegisterLoadingState extends AuthState {}

class RegisterFailedState extends AuthState {
  final String msg;

  RegisterFailedState({required this.msg});
}

class RegisterSuccessState extends AuthState {}

//////////////ForgetPass State////////////
class ForgetPassLoadingState extends AuthState {}

class ForgetPassFailedState extends AuthState {
  final String msg;

  ForgetPassFailedState({required this.msg});
}

class ForgetPassSuccessState extends AuthState {}

///////////Create user ///////////////
class CreateUserLoadingState extends AuthState {}

class CreateUserFailedState extends AuthState {
  final String msg;

  CreateUserFailedState({required this.msg});
}

class CreateUserSuccessState extends AuthState {}

///////////Camera State ///////////////
class CameraLoadingState extends AuthState {}

class CameraFailedState extends AuthState {
  final String msg;
  final bool isProfilePathDet;
  CameraFailedState({required this.msg, required this.isProfilePathDet});
}

class CameraSuccessState extends AuthState {
  final String pathImage;
  final bool isProfilePathDet;

  CameraSuccessState({required this.pathImage, required this.isProfilePathDet});
}
