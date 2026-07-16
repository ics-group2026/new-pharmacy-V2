import '../../../../core/utils/converter.dart';

class BrandModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? image;
  final String? imageAlt;
  final int? sortOrder;
  final String? status;
  final int? totalProducts;
  final int? totalOrders;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BrandModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.imageAlt,
    this.sortOrder,
    this.status,
    this.totalProducts,
    this.totalOrders,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    imageAlt: json['imageAlt'] as String?,
    sortOrder: Converter.toIntOrNull(json['sortOrder']),
    status: json['status'] as String?,
    totalProducts: Converter.toIntOrNull(json['totalProducts']),
    totalOrders: Converter.toIntOrNull(json['totalOrders']),
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
  );
}
