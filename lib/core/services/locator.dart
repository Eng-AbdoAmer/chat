//ToDo 2:create a git_it locator

import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:chat/features/onboarding_splash/presentation/manager/onboarding_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/manager/auth_cubit.dart';
import 'cache_helper.dart';

final locator = GetIt.instance;
//ToDo 3:create a setup method and create our services
Future<void> setUp() async {
  //////////////////////////////OnBoarding ////////
  locator.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());

  ////////////////shared pref////////
  final sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton<CacheHelper>(() => CacheHelper(locator()));
  locator.registerLazySingleton<SharedPreferences>(() => sharedPref);
  //////////////////////////////Auth ////////
  locator.registerLazySingleton<AuthCubit>(() => AuthCubit());

  /////////////Firebase Notification////////////////
  // FirebaseMessaging.instance.getToken().then((token) {
  //   print("token====>" + token.toString());
  //   CacheHelper(locator()).saveData(key: "token", value: token);
  // });
  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  //   // navigateTo(page: const ChatScreen());
  // }

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('onMessage##################');
  //   print('Message data: ${message.data}');
  //   if (message.notification != null) {
  //     //navigateTo(page: const ChatScreen());
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('onMessageOpenedApp@@@@@@@@@@@@@@@@@');
  //   // navigateTo(page: const ChatScreen());
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  FirebaseMessaging.instance.getToken().then((token) {
    print("token====>" + token.toString());
    CacheHelper(locator()).saveData(key: "token", value: token);
  });

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // navigateTo(page: const ChatScreen());
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('onMessage##################');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      // navigateTo(page: const ChatScreen());
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('onMessageOpenedApp@@@@@@@@@@@@@@@@@');
    // navigateTo(page: const ChatScreen());
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

}
