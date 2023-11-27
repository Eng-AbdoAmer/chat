//ToDo 2:create a git_it locator

import 'package:chat/core/shared/helper_meuthods.dart';
import 'package:chat/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:chat/features/home_page/pages/notification.dart';
import 'package:chat/features/onboarding_splash/presentation/manager/onboarding_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

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

  NotificationLocal.init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();

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
    print('Message data: ${message.data}');
    if (message.notification != null) {
      // navigateTo(page: const ChatScreen());
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 10,
        channelKey: "firebase",
        title: message.notification!.title,
        body: message.notification!.body,
      ));
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('onMessageOpenedApp@@@@@@@@@@@@@@@@@');
    // navigateTo(page: const ChatScreen());
    print('Message data: ${message.data}');

    if (message.notification != null) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 10,
        channelKey: "firebase",
        title: message.notification!.title,
        body: message.notification!.body,
      ));
      print('Message also contained a notification: ${message.notification}');
    }
  });

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "firebase",
        channelName: "firebase",
        channelDescription: "notification for firebase",
        importance: NotificationImportance.High,
        playSound: true,
        channelShowBadge: true,
        enableVibration: true,
        enableLights: true,
      ),
    ],
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print("user Sign out!");
    } else {
      print("user Sign in");
    }
  });
}
