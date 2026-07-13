import '../../../../core/utils/converter.dart';
import 'bundle_product.dart';

class BundleModel {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final double? bundlePrice;
  final String? extraDiscountType;
  final double? extraDiscountAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isActive;
  final int? priority;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? computedStatus;
  final double? originalPrice;
  final double? savings;
  final double? savingsPercentage;
  final int? productsCount;
  final List<BundleProduct> products;

  BundleModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.bundlePrice,
    this.extraDiscountType,
    this.extraDiscountAmount,
    this.startDate,
    this.endDate,
    this.isActive,
    this.priority,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.computedStatus,
    this.originalPrice,
    this.savings,
    this.savingsPercentage,
    this.productsCount,
    this.products = const [],
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel(
    id: json['id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    bundlePrice: Converter.toDoubleOrNull(json['bundlePrice']),
    extraDiscountType: json['extraDiscountType'] as String?,
    extraDiscountAmount: Converter.toDoubleOrNull(json['extraDiscountAmount']),
    startDate: json['startDate'] != null
        ? DateTime.tryParse(json['startDate'] as String)
        : null,
    endDate: json['endDate'] != null
        ? DateTime.tryParse(json['endDate'] as String)
        : null,
    isActive: json['isActive'] as bool?,
    priority: Converter.toIntOrNull(json['priority']),
    createdBy: json['createdBy'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
    computedStatus: json['computedStatus'] as String?,
    originalPrice: Converter.toDoubleOrNull(json['originalPrice']),
    savings: Converter.toDoubleOrNull(json['savings']),
    savingsPercentage: Converter.toDoubleOrNull(json['savingsPercentage']),
    productsCount: Converter.toIntOrNull(json['productsCount']),
    products: (json['products'] as List?)
            ?.map((e) => BundleProduct.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );
}
