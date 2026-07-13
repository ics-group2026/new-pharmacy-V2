import 'combo_offer_product.dart';

class ComboOfferModel {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final int? buyQuantity;
  final int? payQuantity;
  final String? offerDetails;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isActive;
  final int? priority;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? computedStatus;
  final List<ComboOfferProduct> products;

  ComboOfferModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.buyQuantity,
    this.payQuantity,
    this.offerDetails,
    this.startDate,
    this.endDate,
    this.isActive,
    this.priority,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.computedStatus,
    this.products = const [],
  });

  factory ComboOfferModel.fromJson(Map<String, dynamic> json) => ComboOfferModel(
    id: json['id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    buyQuantity: json['buyQuantity'] as int?,
    payQuantity: json['payQuantity'] as int?,
    offerDetails: json['offerDetails'] as String?,
    startDate: json['startDate'] != null
        ? DateTime.tryParse(json['startDate'] as String)
        : null,
    endDate: json['endDate'] != null
        ? DateTime.tryParse(json['endDate'] as String)
        : null,
    isActive: json['isActive'] as bool?,
    priority: json['priority'] as int?,
    createdBy: json['createdBy'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
    computedStatus: json['computedStatus'] as String?,
    products: (json['products'] as List?)
            ?.map((e) => ComboOfferProduct.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );
}
