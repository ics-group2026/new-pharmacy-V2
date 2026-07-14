class LocalizedText {
  final String? en;
  final String? ar;

  LocalizedText({this.en, this.ar});

  /// Accepts either a `{en, ar}` map or a plain string, which the API returns
  /// for notifications that have no translations.
  factory LocalizedText.fromJson(dynamic json) {
    if (json is Map) {
      return LocalizedText(en: json['en'] as String?, ar: json['ar'] as String?);
    }
    if (json is String) return LocalizedText(en: json, ar: json);
    return LocalizedText();
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
    title: LocalizedText.fromJson(json['title']),
    body: LocalizedText.fromJson(json['body']),
  );
}

class NotificationModel {
  final String? id;
  final DateTime? readAt;
  final DateTime? createdAt;
  final NotificationInfo? notification;

  NotificationModel({this.id, this.readAt, this.createdAt, this.notification});

  bool get isRead => readAt != null;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json['id'] as String?,
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

  NotificationModel copyWith({DateTime? readAt}) => NotificationModel(
    id: id,
    readAt: readAt ?? this.readAt,
    createdAt: createdAt,
    notification: notification,
  );
}
