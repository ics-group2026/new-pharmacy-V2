import 'flash_deal_product.dart';

class FlashDealModel {
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final String? image;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final bool? isPublished;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? computedStatus;
  final List<FlashDealProduct> products;

  FlashDealModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.image,
    this.startsAt,
    this.endsAt,
    this.isPublished,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.computedStatus,
    this.products = const [],
  });

  factory FlashDealModel.fromJson(Map<String, dynamic> json) => FlashDealModel(
    id: json['id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    type: json['type'] as String?,
    image: json['image'] as String?,
    startsAt: json['startsAt'] != null
        ? DateTime.tryParse(json['startsAt'] as String)
        : null,
    endsAt: json['endsAt'] != null
        ? DateTime.tryParse(json['endsAt'] as String)
        : null,
    isPublished: json['isPublished'] as bool?,
    createdBy: json['createdBy'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
    computedStatus: json['computedStatus'] as String?,
    products: (json['products'] as List?)
            ?.map((e) => FlashDealProduct.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );
}
