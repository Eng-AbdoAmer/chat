import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;

import 'package:bloc/bloc.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/services/cache_helper.dart';
import 'package:chat/core/services/locator.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:chat/features/home_page/data/models/story_model.dart';
import 'package:chat/features/onboarding_splash/presentation/pages/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final StoryController controller = StoryController();
  final TextEditingController commentAtStory = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String nameProfile = locator<CacheHelper>().getData(key: "nameProfile") ?? "";
  String emailProfile =
      locator<CacheHelper>().getData(key: "emailProfile") ?? "";
  String timeProfile = locator<CacheHelper>().getData(key: "timeProfile") ?? "";
  List<UserModel> users = [];
  List<UserModel> searchUsers = [];
  bool isSearching = false;
  final storage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser;
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

  late List<StoryItem> storyItem = [];
  void addStoryItem() {
    storyItem = [];
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

  /*camera function */
  String imageUrl = "";
  bool isProfilePathDet = false;
  XFile? file;
  String filePath = "";
  ImagePicker imagePicker = ImagePicker();

  Future<void> viewImage() async {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text("Chose Profile Image"),
        content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatefulBuilder(
                builder: (context, setStateCamera) => ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      setStateCamera(() {
                        takePhoto(ImageSource.camera);
                      });
                    },
                    label: const Text("camera")),
              ),
              StatefulBuilder(
                builder: (context, setStateGallery) => ElevatedButton.icon(
                    icon: const Icon(Icons.image_outlined),
                    onPressed: () {
                      setStateGallery(() {
                        takePhoto(ImageSource.gallery);
                      });
                    },
                    label: const Text("gallery")),
              ),
            ]),
      ),
    );
    //TODo:setState heir is mast
  }

  void setImagePath(String path) {
    if (filePath != "") {
      filePath = path;
      isProfilePathDet = true;
      //TODO:back to screen you need must
      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  void takePhoto(ImageSource source) async {
    emit(CameraLoadingState());
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    try {
      file = XFile(pickedImage!.path);
      if (file!.path != null) {
        filePath = file!.path;
        emit(CameraSuccessState(pathImage: filePath, isProfilePathDet: true));
        print("file path is>>>>>>" + filePath);
        setImagePath(file!.path);
      } else {
        emit(CameraFailedState(
            msg: "please try again", isProfilePathDet: false));
      }
    } catch (e) {
      emit(CameraFailedState(msg: e.toString(), isProfilePathDet: false));
    }
  }

  upLoadImageToStorage({required XFile file}) async {
    print("file===>" + file.path.toString());
    emit(UploadImageLoadingState());

    try {
      Random random = new Random();
      int randomNumber = random.nextInt(100);
      // final ref = storage.ref().child("staties").child(file.name.toString());
      // print("randomNumber.toString() + file.name" +
      //     randomNumber.toString() +
      //     file.name);
      final fileName = path.basename(file.path);
      final ref = storage.ref().child("staties").child(fileName);
      await ref.putFile(File(file.path));

      final url = await ref.getDownloadURL();
      imageUrl = url;
      emit(UploadImageSuccessState(imageUrl: url, file: File(file.path)));
    } catch (e) {
      emit(UploadImageFailedState(msg: e.toString()));
    }
  }
}
