// // ignore_for_file: use_build_context_synchronously
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:client/core/network/local/sharedpreference.dart';
// import 'package:client/map/logic/map_cubit.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// import '../models/chnage_status_model.dart';
// import '../models/notfications_fare_mdoel.dart';
// import '../models/receiving_order_model_notfication.dart';
// import '../models/send_message_chat.dart';
// import '../utils/routes_manager.dart';

// class NotificationLocal {
//   static Future init() async {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//     FirebaseMessaging.onMessage.listen((event) {
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 1,
//           channelKey: "firebase",
//           title: event.notification?.title,
//           body: event.notification?.body,
//         ),
//       );
//       AwesomeNotifications().createNotificationFromJsonData(event.data);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 2,
//           channelKey: "firebase",
//           title: event.notification?.title,
//           body: event.notification?.body,
//         ),
//       );
//       AwesomeNotifications().createNotificationFromJsonData(event.data);
//     });
//   }
// }
//   // static initNotfiationsFare({required BuildContext context}) async {
//   //   FirebaseMessaging.onMessage.listen((event) {
//   //     NotfiationsFare? notfiationsFare;
//   //     notfiationsFare = NotfiationsFare.fromJson(event.data);
//   //     if (notfiationsFare.notification == "true") {
//   //       MapCubit.get(context).listNotfiationsFare.add(notfiationsFare);
//   //       MapCubit.get(context).emitListNotfiationsFare();
//   //     }
//   //   });
//     // FirebaseMessaging.onMessageOpenedApp.listen((event) {
//     //   NotfiationsFare? notfiationsFare;
//     //   notfiationsFare = NotfiationsFare.fromJson(event.data);

//     //   if (notfiationsFare.notification == "true") {
//     //     MapCubit.get(context).listNotfiationsFare.add(notfiationsFare);
//     //     MapCubit.get(context).emitListNotfiationsFare();
//     //   }
//     // });
//     // FirebaseMessaging.onBackgroundMessage((message) async {
//     //   var massage = await FirebaseMessaging.instance.getInitialMessage();
//     //   if (massage != null) {
//     //     NotfiationsFare? notfiationsFare;
//     //     notfiationsFare = NotfiationsFare.fromJson(message.data);
//     //     if (notfiationsFare.notification == "true") {
//     //       MapCubit.get(context).listNotfiationsFare.add(notfiationsFare);
//     //       MapCubit.get(context).emitListNotfiationsFare();
//     //     }
//     //   }
//     // });




//   // static initNotfiationsReceivingOrder({required BuildContext context}) async {
//   //   FirebaseMessaging.onMessage.listen((event) {
//   //     ReceivingOrderNotfiations? receivingOrderNotfiations;
//   //     receivingOrderNotfiations =
//   //         ReceivingOrderNotfiations.fromJson(event.data);
//   //     if (receivingOrderNotfiations.receivingOrder == "true") {
//         // CacheHelper.saveData(
//         //     key: "orderCode", value: receivingOrderNotfiations.orderCode!);
//         // Navigator.pushReplacementNamed(context, Routes.showSuccessTripScreen,
//         //     arguments: receivingOrderNotfiations.orderCode!);
//   //     }
//   //   });
//   //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//   //     ReceivingOrderNotfiations? receivingOrderNotfiations;
//   //     receivingOrderNotfiations =
//   //         ReceivingOrderNotfiations.fromJson(event.data);
//   //     if (receivingOrderNotfiations.receivingOrder == "true") {
//   //       CacheHelper.saveData(
//   //           key: "orderCode", value: receivingOrderNotfiations.orderCode!);
//   //       Navigator.pushNamedAndRemoveUntil(
//   //           context, Routes.showSuccessTripScreen, (route) => false,
//   //           arguments: receivingOrderNotfiations.orderCode!);
//   //     }
//   //   });
//   //   // FirebaseMessaging.onBackgroundMessage((message) async {
//   //   //   var massage = await FirebaseMessaging.instance.getInitialMessage();
//   //   //   if (massage != null) {
//   //   //     ReceivingOrderNotfiations? receivingOrderNotfiations;
//   //   //     receivingOrderNotfiations =
//   //   //         ReceivingOrderNotfiations.fromJson(massage.data);
//   //   //     if (receivingOrderNotfiations.receivingOrder == "true") {
//   //   //       CacheHelper.saveData(
//   //   //           key: "orderCode", value: receivingOrderNotfiations.orderCode!);
//   //   //       Navigator.pushNamedAndRemoveUntil(
//   //   //           context, Routes.showSuccessTripScreen, (route) => false,
//   //   //           arguments: receivingOrderNotfiations.orderCode!);
//   //   //     }
//   //   //   }
//   //   // });
//   // }





//   // static initNotfiationsToChangeStatusOrder(
//   //     {required BuildContext context}) async {
//   //   FirebaseMessaging.onMessage.listen((event) {
//   //     ChangeStatusNotfiations? changeStatusNotfiations;
//   //     changeStatusNotfiations = ChangeStatusNotfiations.fromJson(event.data);
//   //     if (changeStatusNotfiations.changeStatus == "true") {
//   //       MapCubit.get(context)
//   //           .getOrder(orderCode: CacheHelper.getData(key: "orderCode"));
//   //     }
//   //   });
//   //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//   //     ChangeStatusNotfiations? changeStatusNotfiations;
//   //     changeStatusNotfiations = ChangeStatusNotfiations.fromJson(event.data);
//   //     if (changeStatusNotfiations.changeStatus == "true") {
//   //       MapCubit.get(context)
//   //           .getOrder(orderCode: CacheHelper.getData(key: "orderCode"));
//   //     }
//   //   });
//   //   //   FirebaseMessaging.onBackgroundMessage((message) async {
//   //   //     var massage = await FirebaseMessaging.instance.getInitialMessage();
//   //   //     if (massage != null) {
//   //   //       ChangeStatusNotfiations? changeStatusNotfiations;
//   //   //       changeStatusNotfiations =
//   //   //           ChangeStatusNotfiations.fromJson(massage.data);
//   //   //       if (changeStatusNotfiations.changeStatus == "true") {
//   //   //         MapCubit.get(context)
//   //   //             .getOrder(orderCode: CacheHelper.getData(key: "orderCode"));
//   //   //       }
//   //   //     }
//   //   //   });
//   //   // }
//   // }

// //   static initNotfiationsToSendMessage({required BuildContext context}) async {
// //     FirebaseMessaging.onMessage.listen((event) {
// //       SendMessageInChat? sendMessageInChat;
// //       sendMessageInChat = SendMessageInChat.fromJson(event.data);
// //       if (sendMessageInChat.sendNotfications == "true") {
// //         MapCubit.get(context)
// //             .listNotficationsSend
// //             .add(sendMessageInChat.index!);
// //         MapCubit.get(context).emitlistNotficationsReciver();
// //       }
// //     });
// //     FirebaseMessaging.onMessageOpenedApp.listen((event) {
// //       SendMessageInChat? sendMessageInChat;
// //       sendMessageInChat = SendMessageInChat.fromJson(event.data);
// //       if (sendMessageInChat.sendNotfications == "true") {
// //         MapCubit.get(context)
// //             .listNotficationsSend
// //             .add(sendMessageInChat.index!);
// //         MapCubit.get(context).emitlistNotficationsReciver();
// //       }
// //     });
// //   }
// // }
// /*
// ToDo: Add Comment in main
// AwesomeNotifications().initialize(null, [
//     NotificationChannel(
//       channelKey: "firebase",
//       channelName: "firebase",
//       channelDescription: "notification for firebase",
//       importance: NotificationImportance.High,
//       playSound: true,
//       channelShowBadge: true,
//       enableVibration: true,
//       enableLights: true,
//     ),

// NotificationLocal.init(),






//   */
