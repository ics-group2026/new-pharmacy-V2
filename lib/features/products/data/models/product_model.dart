import '../../../../core/utils/converter.dart';
import 'product_image.dart';
import 'product_vendor.dart';

class ProductModel {
  final String? id;
  final String? name;
  final String? productType;
  final String? categoryId;
  final String? brandId;
  final ProductRef? category;
  final ProductRef? brand;
  final ProductImage? image;
  final int? variantsCount;
  final double? price;
  final double? sellingPrice;
  final int? totalStock;
  final String? status;
  final String? approvalStatus;
  final bool? isActive;
  final bool? isFeatured;
  final bool? refundable;
  final bool? cashOnDelivery;
  final DateTime? createdAt;
  final ProductVendor? vendor;

  const ProductModel({
    this.id,
    this.name,
    this.productType,
    this.categoryId,
    this.brandId,
    this.category,
    this.brand,
    this.image,
    this.variantsCount,
    this.price,
    this.sellingPrice,
    this.totalStock,
    this.status,
    this.approvalStatus,
    this.isActive,
    this.isFeatured,
    this.refundable,
    this.cashOnDelivery,
    this.createdAt,
    this.vendor,
  });

  /// A price below [price] signals a discount.
  bool get hasDiscount =>
      price != null && sellingPrice != null && sellingPrice! < price!;

  /// Rounded percentage off, or null when there is no discount.
  int? get discountPercent {
    if (!hasDiscount || price == 0) return null;
    return (((price! - sellingPrice!) / price!) * 100).round();
  }

  bool get inStock => (totalStock ?? 0) > 0;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    productType: json['productType'] as String?,
    categoryId: json['categoryId'] as String?,
    brandId: json['brandId'] as String?,
    category: json['category'] != null
        ? ProductRef.fromJson(json['category'] as Map<String, dynamic>)
        : null,
    brand: json['brand'] != null
        ? ProductRef.fromJson(json['brand'] as Map<String, dynamic>)
        : null,
    image: json['image'] != null
        ? ProductImage.fromJson(json['image'] as Map<String, dynamic>)
        : null,
    variantsCount: Converter.toIntOrNull(json['variantsCount']),
    price: Converter.toDoubleOrNull(json['price']),
    sellingPrice: Converter.toDoubleOrNull(json['sellingPrice']),
    totalStock: Converter.toIntOrNull(json['totalStock']),
    status: json['status'] as String?,
    approvalStatus: json['approvalStatus'] as String?,
    isActive: json['isActive'] as bool?,
    isFeatured: json['isFeatured'] as bool?,
    refundable: json['refundable'] as bool?,
    cashOnDelivery: json['cashOnDelivery'] as bool?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    vendor: json['vendor'] != null
        ? ProductVendor.fromJson(json['vendor'] as Map<String, dynamic>)
        : null,
  );
}

/// A lightweight id/name reference, shared by `category` and `brand`.
class ProductRef {
  final String? id;
  final String? name;

  ProductRef({this.id, this.name});

  factory ProductRef.fromJson(Map<String, dynamic> json) =>
      ProductRef(id: json['id'] as String?, name: json['name'] as String?);
}
