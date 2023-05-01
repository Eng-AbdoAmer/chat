import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future googleSignIn() async {
  final googleSignIn = GoogleSignIn();
  final googleAccount = await googleSignIn.signIn();
  print(googleAccount!.email.toString());
  final googleCredential = await googleAccount.authentication;
  print(googleCredential.idToken);
  print(googleCredential.accessToken);
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
}
