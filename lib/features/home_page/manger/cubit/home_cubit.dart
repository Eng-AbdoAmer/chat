import 'package:bloc/bloc.dart';
import 'package:chat/core/services/cache_helper.dart';
import 'package:chat/core/services/locator.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:chat/features/onboarding_splash/presentation/pages/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String nameProfile = locator<CacheHelper>().getData(key: "nameProfile") ?? "";
  String emailProfile =
      locator<CacheHelper>().getData(key: "emailProfile") ?? "";
  String timeProfile = locator<CacheHelper>().getData(key: "timeProfile") ?? "";
  List<UserModel> users = [];
  Future<void> getUser() async {
    users = [];
    emit(GetUserLoadingState());
    fireStore.collection("Users").get().then((snapshot) {
      snapshot.docs.forEach((element) {
        // String id = locator<CacheHelper>().getData(key: "uID");
        String accountEmail = locator<CacheHelper>().getData(key: "AccountEmail");

        if (element.data()['email'] != accountEmail) {
          users.add(UserModel.fromJson(element.data()));
          emit(GetUserSuccessState(model: users));
        } else {
          print(element.data()['email']);
          print(element.data()['name']);
          print(element.data()['time']);
          locator<CacheHelper>()
              .saveData(key: "emailProfile", value: element.data()['email']);
          locator<CacheHelper>()
              .saveData(key: "nameProfile", value: element.data()['name']);
          locator<CacheHelper>()
              .saveData(key: "timeProfile", value: element.data()['time']);
        }
      });
    }).catchError((e) {
      emit(GetUserFailedState(msg: e.toString()));
    });
  }

  Future signOut(BuildContext context) async {
    locator<CacheHelper>().removeAllData();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SplashScreen()),
        (route) => false);
  }
}
