// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../services/cache_helper.dart';
// import '../services/locator.dart';
//
// Future googleSignIn() async {
//   final googleSignIn = GoogleSignIn();
//   final googleAccount = await googleSignIn.signIn();
//   print(googleAccount!.email.toString());
//   final googleCredential = await googleAccount.authentication;
//   print(googleCredential.idToken);
//   print(googleCredential.accessToken);
//   final authCredential = GoogleAuthProvider.credential(
//       idToken: googleCredential.idToken,
//       accessToken: googleCredential.accessToken);
//   final firebaseUser =
//       await FirebaseAuth.instance.signInWithCredential(authCredential);
//   print(firebaseUser.user!.uid);
//   print(firebaseUser.user!.displayName);
//   print(firebaseUser.user!.email);
//   print(firebaseUser.user!.phoneNumber);
//   print(firebaseUser.user!.photoURL);
// }
//
// //////////////////
// String? fbName;
// String? fbEmail;
// String? fbImageUrl;
// final FirebaseAuth _auth = FirebaseAuth.instance;
// Future<String?> signInWithFacebook2() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();
//   // final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   var a = await loginResult.message;
//   print(a);
//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken!.token);
//   print("facebookAuthCredential22 ${facebookAuthCredential.token}");
//   print("facebookAuthCredential33 ${facebookAuthCredential.accessToken}");
//   print("facebookAuthCredential44 ${facebookAuthCredential.rawNonce}");
//   // Once signed in, return the UserCredential
//   final UserCredential authResult =
//       await _auth.signInWithCredential(facebookAuthCredential);
//   final User? users = authResult.user;
//   final UserInfo? user = users!.providerData[0];
//   print("facebookAuthCredential11 $user");
//   // return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//
//   if (user != null) {
//     // Checking if email and name is null
//     // assert(user.email != null);
//     assert(user.displayName != null);
//     assert(user.photoURL != null);
//     locator<CacheHelper>()
//         .saveData(key: "socialName", value: user.displayName.toString());
//     locator<CacheHelper>()
//         .saveData(key: "socialEmail", value: user.email.toString());
//     locator<CacheHelper>()
//         .saveData(key: "socialImage", value: user.photoURL.toString());
//     print(user.email.toString());
//     print(user.displayName.toString());
//     print(user.phoneNumber.toString());
//     print(user.photoURL.toString());
//
//     assert(!users.isAnonymous);
//     assert(await users.getIdToken() != null);
//
//     final User? currentUser = _auth.currentUser;
//     assert(users.uid == currentUser!.uid);
//
//     print('signInWithFacebook succeeded: $user');
//
//     return '$user';
//   }
//
//   return null;
// }
