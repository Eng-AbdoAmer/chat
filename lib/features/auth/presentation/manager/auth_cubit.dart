import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:chat/core/constant/app_strings.dart';
import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/presentation/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/functions/app_dialoge.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? userName, email, phone, photoURL, token, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPhotoUrlController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool isEmailVerified = false;
  GlobalKey<FormState> forgetPassword = GlobalKey();
  GlobalKey<FormState> registerKey = GlobalKey();
  GlobalKey<FormState> loginKey = GlobalKey();
  var scaffoldKeyRegister = GlobalKey<ScaffoldState>();
  var scaffoldKeyLogin = GlobalKey<ScaffoldState>();
  var scaffoldKeyResit = GlobalKey<ScaffoldState>();
  String imageUrl = "";
  bool isProfilePathDet = false;
  XFile? file;
  String filePath = "";
  ImagePicker imagePicker = ImagePicker();
  ///////////////////////////////////Function/////////////////////////////////
  Future checkCurrentAuthState() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future checkEmailVerified() async {
    isEmailVerified = _auth.currentUser!.emailVerified;
    if (isEmailVerified) {
      ///go to login Screen
      ScaffoldMessenger.of(navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text("content")));
      _auth.currentUser!.sendEmailVerification();
    } else {
      ///go to home Screen
      ScaffoldMessenger.of(navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text("content")));
    }
  }

  Future createUserWithEmailAndPassword() async {
    try {
      emit(RegisterLoadingState());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmailController.text.trim(),
        password: userPasswordController.text.trim(),
      );
      String id = credential.user!.uid;
      locator<CacheHelper>().saveData(key: "uID", value: id.toString());
      String account_email = credential.user!.email!;
      locator<CacheHelper>()
          .saveData(key: "AccountEmail", value: account_email.toString());
      verifyEmail();
      createUser(id: id, email: account_email);
      locator<CacheHelper>().saveData(key: "isLogin", value: true);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailedState(msg: e.code));
    } catch (e) {
      emit(RegisterFailedState(msg: e.toString()));
    }
  }

  Future signInWithEmailAndPassword() async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmailController.text,
        password: userPasswordController.text,
      );
      locator<CacheHelper>()
          .saveData(key: "AccountEmail", value: userEmailController.text);
      emit(LoginSuccessState());
      var isLogin =
          locator<CacheHelper>().saveData(key: "isLogin", value: true);
    } on FirebaseAuthException catch (e) {
      emit(LoginFailedState(msg: e.code));
      locator<CacheHelper>().saveData(key: "isLogin", value: false);
    }
  }

  Future verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    print(googleAccount!.email.toString());
    final googleCredential = await googleAccount.authentication;
    print(googleCredential.idToken);
    print(googleCredential.accessToken);
    token = googleCredential.accessToken;
    final authCredential = GoogleAuthProvider.credential(
        idToken: googleCredential.idToken,
        accessToken: googleCredential.accessToken);
    final firebaseUser =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    print(firebaseUser.user!.uid);
    print(firebaseUser.user!.displayName);
    print(firebaseUser.user!.email);
    print(firebaseUser.user!.phoneNumber);
    print(firebaseUser.user!.photoURL);
    var isLogin = locator<CacheHelper>().saveData(key: "isLogin", value: true);
    locator<CacheHelper>().saveData(
        key: "socialName", value: firebaseUser.user!.displayName.toString());
    locator<CacheHelper>().saveData(
        key: "socialEmail", value: firebaseUser.user!.email.toString());
    locator<CacheHelper>().saveData(
        key: "socialImage", value: firebaseUser.user!.photoURL.toString());
    userName = firebaseUser.user!.displayName;
    email = firebaseUser.user!.email;
    phone = firebaseUser.user!.phoneNumber;
    photoURL = firebaseUser.user!.photoURL;
    emit(LoginSuccessState());
  }

  Future<String?> signInWithFacebook2() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    var a = await loginResult.message;
    print(a);
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    print("facebookAuthCredential22 ${facebookAuthCredential.token}");
    print("facebookAuthCredential33 ${facebookAuthCredential.accessToken}");
    print("facebookAuthCredential44 ${facebookAuthCredential.rawNonce}");
    final UserCredential authResult =
        await _auth.signInWithCredential(facebookAuthCredential);
    final User? users = authResult.user;
    final UserInfo? user = users!.providerData[0];
    print("facebookAuthCredential11 $user");
    if (user != null) {
      locator<CacheHelper>().saveData(key: "isLogin", value: true);
      emit(LoginSuccessState());
      userName = user.displayName.toString();
      phone = user.phoneNumber.toString();
      email = user.email.toString();
      token = facebookAuthCredential.token.toString();
      photoURL = user.photoURL.toString();
      locator<CacheHelper>()
          .saveData(key: "socialName", value: user.displayName.toString());
      locator<CacheHelper>()
          .saveData(key: "socialEmail", value: user.email.toString());
      locator<CacheHelper>()
          .saveData(key: "socialImage", value: user.photoURL.toString());
      print(user.email.toString());
      print(user.displayName.toString());
      print(user.phoneNumber.toString());
      print(user.photoURL.toString());

      final User? currentUser = _auth.currentUser;
      assert(users.uid == currentUser!.uid);

      print('signInWithFacebook succeeded: $user');

      return '$user';
    }

    return null;
  }

  Future<void> onPressLoginWithEmailAndPassword() async {
    if (loginKey.currentState!.validate()) {
      signInWithEmailAndPassword();
    }
  }

  Future<void> onPressRegister() async {
    if (registerKey.currentState!.validate()) {
      createUserWithEmailAndPassword();
    }
  }

  Future<void> resetPassword() async {
    emit(ForgetPassLoadingState());
    await _auth
        .sendPasswordResetEmail(email: userEmailController.text.trim())
        .then((value) {
      emit(ForgetPassSuccessState());
    }).catchError((e) {
      emit(ForgetPassFailedState(msg: e.toString()));
    });
  }

  Future<void> createUser({String? id, required String email}) async {
    emit(CreateUserLoadingState());
    UserModel userModel = UserModel(
      uId: "id",
      image: imageUrl,
      isActive: true,
      time: DateFormat.jm().format(DateTime.now()).toString(),
      email: email,
      name: nameController.text.trim(),
      password: userPasswordController.text.trim(),
      phone: userPhoneController.text.trim(),
    );
    fireStore
        .collection("Users")
        .doc(email)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((e) {
      emit(CreateUserFailedState(msg: e.toString()));
    });
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

  Future<void> viewImage({void Function()? setState}) async {
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

  upLoadImageToStorage({required XFile file}) async {
    final storage = FirebaseStorage.instance;
    final fireStore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    //لفتح ملف الصورا storage و تخزينها
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    final ref = storage
        .ref()
        .child("images")
        .child(randomNumber.toString() + file.name);
    await ref.putFile(File(file.path));
    final url = await ref.getDownloadURL();
    print(url);
    imageUrl = url;
  }
}
