import '../../../../core/constants/end_points.dart';

class BannerModel {
  final String id;
  final String? title;
  final String type;
  final String? resourceType;
  final String? resourceId;
  final String? url;
  final String image;
  final String? altText;
  final bool isPublished;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final String? computedStatus;


  BannerModel({
    required this.id,
    this.title,
    required this.type,
    this.resourceType,
    this.resourceId,
    this.url,
    required this.image,
    this.altText,
    required this.isPublished,
    this.startsAt,
    this.endsAt,
    this.computedStatus,

  });

  /// The API may return either an absolute URL or a server-relative path.
  String get imageUrl => image.startsWith('http')
      ? image
      : '${EndPoints.mediaBaseUrl}$image';

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json['id'] as String,
    title: _parseTitle(json['title']),
    type: json['type'] as String,
    resourceType: json['resourceType'] as String?,
    resourceId: json['resourceId'] as String?,
    url: json['url'] as String?,
    image: json['image'] as String,
    altText: json['altText'] as String?,
    isPublished: json['isPublished'] as bool? ?? false,
    startsAt: _parseDate(json['startsAt']),
    endsAt: _parseDate(json['endsAt']),
    computedStatus: json['computedStatus'] as String?,
  );

  // The API declares `title` loosely, so it may arrive as a plain string or a
  // localized map.
  static String? _parseTitle(dynamic value) {
    if (value is String) return value;
    if (value is Map) return (value['en'] ?? value['ar'])?.toString();
    return null;
  }

  static DateTime? _parseDate(dynamic value) =>
      value is String ? DateTime.tryParse(value) : null;
}
