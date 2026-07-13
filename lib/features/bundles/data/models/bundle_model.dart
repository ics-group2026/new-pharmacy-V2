import 'bundle_product.dart';

class BundleModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final double bundlePrice;
  final String? extraDiscountType;
  final double? extraDiscountAmount;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final int priority;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String computedStatus;
  final double originalPrice;
  final double savings;
  final double savingsPercentage;
  final int productsCount;
  final List<BundleProduct> products;

  BundleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.bundlePrice,
    this.extraDiscountType,
    this.extraDiscountAmount,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.priority,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.computedStatus,
    required this.originalPrice,
    required this.savings,
    required this.savingsPercentage,
    required this.productsCount,
    required this.products,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    bundlePrice: (json['bundlePrice'] as num).toDouble(),
    extraDiscountType: json['extraDiscountType'] as String?,
    extraDiscountAmount: (json['extraDiscountAmount'] as num?)?.toDouble(),
    startDate: DateTime.parse(json['startDate'] as String),
    endDate: DateTime.parse(json['endDate'] as String),
    isActive: json['isActive'] as bool,
    priority: json['priority'] as int,
    createdBy: json['createdBy'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    computedStatus: json['computedStatus'] as String,
    originalPrice: (json['originalPrice'] as num).toDouble(),
    savings: (json['savings'] as num).toDouble(),
    savingsPercentage: (json['savingsPercentage'] as num).toDouble(),
    productsCount: json['productsCount'] as int,
    products: (json['products'] as List)
        .map((e) => BundleProduct.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
