import 'combo_offer_product.dart';

class ComboOfferModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final int buyQuantity;
  final int payQuantity;
  final String offerDetails;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final int priority;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String computedStatus;
  final List<ComboOfferProduct> products;

  ComboOfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.buyQuantity,
    required this.payQuantity,
    required this.offerDetails,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.priority,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.computedStatus,
    required this.products,
  });

  factory ComboOfferModel.fromJson(Map<String, dynamic> json) => ComboOfferModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    buyQuantity: json['buyQuantity'] as int,
    payQuantity: json['payQuantity'] as int,
    offerDetails: json['offerDetails'] as String,
    startDate: DateTime.parse(json['startDate'] as String),
    endDate: DateTime.parse(json['endDate'] as String),
    isActive: json['isActive'] as bool,
    priority: json['priority'] as int,
    createdBy: json['createdBy'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    computedStatus: json['computedStatus'] as String,
    products: (json['products'] as List)
        .map((e) => ComboOfferProduct.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
