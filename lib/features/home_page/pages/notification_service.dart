import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat/core/constant/app_colors.dart';
import 'package:chat/core/shared/helper_meuthods.dart';

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: "newChannelKey",
          channelKey: "newChannelKey",
          channelName: "channelName",
          channelDescription: "channelDescription",
          defaultColor: AppColors.primaryColor,
          ledColor: AppColors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "channelGroupKey",
          channelGroupName: "channelGroupName",
        )
      ],
      debug: true,
    );
    await AwesomeNotifications().isNotificationAllowed().then((isAllow) async {
      if (!isAllow) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("onNotificationCreatedMethod");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("onNotificationDisplayedMethod");
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("onActionReceivedMethod");
    final payload = receivedAction.payload ?? {};
    if (payload['navigate'] == "true") {
      //!change page hear important
     // navigateTo(page: "page");
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("onDismissActionReceivedMethod");
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButton,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: "channelKey",
          title: title,
          actionType: actionType,
          bigPicture: bigPicture,
          body: body,
          category: category,
          payload: payload,
          summary: summary,
          notificationLayout: notificationLayout,
        ),
        actionButtons: actionButton,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true,
              )
            : null);
  }
}
