import 'dart:io';
import 'dart:math';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/prefs.dart';
import '../../../../core/services/push_notification_service.dart';

class DeviceInfoModel {
  final String token;
  final String platform;
  final String deviceId;

  DeviceInfoModel({
    required this.token,
    required this.platform,
    required this.deviceId,
  });

  Map<String, String> toJson() => {
    "token": token,
    "platform": platform,
    "deviceId": deviceId,
  };

  /// Builds the device payload sent with login/register: the FCM push
  /// token fetched at app startup, the OS name, and a per-install id
  /// persisted locally (no native device-info plugin needed since the
  /// backend only uses this to tell installs apart).
  factory DeviceInfoModel.current() => DeviceInfoModel(
    token: PushNotificationService.fcmToken ?? '',
    platform: Platform.isIOS ? 'IOS' : 'ANDROID',
    deviceId: _getOrCreateDeviceId(),
  );

  static String _getOrCreateDeviceId() {
    final existing = Prefs.getString(kDeviceId);
    if (existing != null) return existing;

    final id =
        '${DateTime.now().microsecondsSinceEpoch}-${Random().nextInt(1 << 32)}';
    Prefs.setString(kDeviceId, id);
    return id;
  }
}
