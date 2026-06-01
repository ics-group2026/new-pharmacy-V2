import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/notification_model.dart';
import 'local_notification_service.dart';

class PushNotificationService {
  static String? fcmToken;
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // await _messaging.requestPermission();
    try {
      fcmToken = await _messaging.getToken();
    } on Exception catch (e) {
      log("there is an error while getting FCM token :$e");
    }
    log(fcmToken ?? "null");
    onBackGroundMessage();
    onForegroundMessage();
    _messaging.subscribeToTopic("All");
  }

  static Future<void> onBackGroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_handler);
  }

  static void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(onData);
  }

  static Future<void> onData(RemoteMessage message) async {
    LocalNotificationService.showBasicNotification(
      notificationModel: NotificationModel(
        id: message.messageId.hashCode,
        title: message.notification?.title.toString() ?? "null",
        body: message.notification?.body.toString() ?? "null",
        payload: message.data.toString(),
      ),
    );
    log(message.messageId.hashCode.toString());
  }

  static Future<void> _handler(RemoteMessage message) async {
    log(message.notification?.title.toString() ?? "null");
  }

  static Future<void> sendTokenToServer(String token) async {}
}
