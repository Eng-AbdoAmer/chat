import 'package:bloc/bloc.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/services/cache_helper.dart';
import 'package:chat/core/services/locator.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:chat/features/home_page/data/models/story_model.dart';
import 'package:chat/features/onboarding_splash/presentation/pages/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final StoryController controller = StoryController();

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
        String accountEmail =
            locator<CacheHelper>().getData(key: "AccountEmail");

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

  List<StoryModel> storyModelList = [];
  Future<void> getStories({required String emailSender}) async {
    storyModelList = [];
    emit(StoriesLoadingState());
    fireStore
        .collection("Users")
        .doc(emailSender)
        .collection("stories")
        .get()
        .then((snapshot) {
      print(snapshot.docs.length);
      snapshot.docs.forEach((story) {
        storyModelList.add(StoryModel.fromJson(story.data()));

        emit(StoriesSuccessState(model: storyModelList));
      });
    }).catchError((error) {
      emit(StoriesFailedState(msg: error.toString()));
    });
  }

  Future<void> addStories({
    required String senderEmail,
    required String mediaType,
    String? comment,
    String? title,
    String? imageUrl,
  }) async {
    emit(StoriesLoadingState());
    StoryModel storyModel = StoryModel(
        mediaType: mediaType,
        senderEmail: senderEmail,
        caption: comment ?? "",
        title: title ?? "",
        imageUrl: imageUrl ?? "");
    try {
      fireStore
          .collection("Users")
          .doc(senderEmail)
          .collection("stories")
          .add(storyModel.toJson())
          .then((value) {
        emit(StoriesAddSuccessState());
      });
    } catch (error) {
      emit(StoriesFailedState(msg: error.toString()));
    }
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

  final storyItem = <StoryItem>[];
  void addStoryItem({required StoryController controller}) {
    for (final story in storyModelList) {
      if (story.mediaType == MediaType.image.name) {
        storyItem.add(StoryItem.pageImage(
            url: story.imageUrl!,
            controller: controller,
            caption: story.caption,
            duration: const Duration(seconds: 3)));
      } else if (story.mediaType == MediaType.text.name) {
        storyItem.add(StoryItem.text(
            title: story.title!, backgroundColor: AppColors.grey));
      }
    }
  }
}
