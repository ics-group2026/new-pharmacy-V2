class LocalizedText {
  final String? en;
  final String? ar;

  LocalizedText({this.en, this.ar});

  factory LocalizedText.fromJson(Map<String, dynamic>? json) {
    if (json == null) return LocalizedText();
    return LocalizedText(en: json['en'] as String?, ar: json['ar'] as String?);
  }

  String localized(String languageCode) {
    final value = languageCode == 'ar' ? ar : en;
    return value ?? en ?? ar ?? '';
  }
}

class NotificationInfo {
  final LocalizedText title;
  final LocalizedText body;

  NotificationInfo({required this.title, required this.body});

  factory NotificationInfo.fromJson(Map<String, dynamic> json) => NotificationInfo(
    title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>?),
    body: LocalizedText.fromJson(json['body'] as Map<String, dynamic>?),
  );
}

class NotificationModel {
  final DateTime? readAt;
  final DateTime? createdAt;
  final NotificationInfo? notification;

  NotificationModel({this.readAt, this.createdAt, this.notification});

  bool get isRead => readAt != null;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    readAt: json['readAt'] != null
        ? DateTime.tryParse(json['readAt'] as String)
        : null,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    notification: json['notification'] != null
        ? NotificationInfo.fromJson(json['notification'] as Map<String, dynamic>)
        : null,
  );
}
