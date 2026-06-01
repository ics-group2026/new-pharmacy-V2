import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/notification_model.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();
  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  //! ---------------- 1 setup local notification ----------------------------
  static Future<void> init() async {
    final InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
    await requestPermission();
  }

  //! ---------------- 2 show basic local notification ------------------------
  static Future<void> showBasicNotification({
    required NotificationModel notificationModel,
  }) async {
    final AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
          "id_1",
          "Basic notification",
          importance: Importance.max,
          priority: Priority.high,
        );

    final DarwinNotificationDetails iOS = const DarwinNotificationDetails();

    final NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOS,
    );
    //-----------------------------------------------------------------
    await flutterLocalNotificationsPlugin.show(
      notificationModel.id,
      notificationModel.title,
      notificationModel.body,
      details,
      payload: notificationModel.payload,
    );
  }

  //!----------------- 7 request permission -----------------------------------
  static Future<void> requestPermission() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }
}
