import '../../../../core/models/localized_text.dart';
import '../../../../core/utils/converter.dart';
import 'product_image.dart';
import 'product_variant.dart';
import 'product_vendor.dart';

class ProductDetailsModel {
  final String? id;
  final LocalizedText? name;
  final LocalizedText? slug;
  final LocalizedText? description;
  final String? videoUrl;
  final List<String> tags;
  final String? productType;
  final String? unitId;
  final double? taxAmount;
  final String? taxType;
  final String? taxModel;
  final int? minOrderQty;
  final int? maxOrderQty;
  final double? shippingCost;
  final bool? multiplyShippingByQty;
  final bool? refundable;
  final bool? cashOnDelivery;
  final bool? isFeatured;
  final bool? requiresPrescription;
  final String? status;
  final bool? isActive;
  final String? categoryId;
  final String? brandId;
  final ProductTaxonomy? category;
  final ProductTaxonomy? brand;
  final ProductVendor? vendor;
  final double? averageRating;
  final int? totalReviews;
  final ProductSeoMeta? seoMeta;
  final ProductImage? image;
  final List<ProductImage> images;
  final List<ProductVariant> variants;
  final int? variantsCount;
  final ProductVariant? defaultVariant;
  final int? totalStock;
  final double? price;
  final double? sellingPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductDetailsModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.videoUrl,
    this.tags = const [],
    this.productType,
    this.unitId,
    this.taxAmount,
    this.taxType,
    this.taxModel,
    this.minOrderQty,
    this.maxOrderQty,
    this.shippingCost,
    this.multiplyShippingByQty,
    this.refundable,
    this.cashOnDelivery,
    this.isFeatured,
    this.requiresPrescription,
    this.status,
    this.isActive,
    this.categoryId,
    this.brandId,
    this.category,
    this.brand,
    this.vendor,
    this.averageRating,
    this.totalReviews,
    this.seoMeta,
    this.image,
    this.images = const [],
    this.variants = const [],
    this.variantsCount,
    this.defaultVariant,
    this.totalStock,
    this.price,
    this.sellingPrice,
    this.createdAt,
    this.updatedAt,
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

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json['id'] as String?,
        name: LocalizedText.fromJson(json['name']),
        slug: LocalizedText.fromJson(json['slug']),
        description: LocalizedText.fromJson(json['description']),
        videoUrl: json['videoUrl'] as String?,
        tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        productType: json['productType'] as String?,
        unitId: json['unitId'] as String?,
        taxAmount: Converter.toDoubleOrNull(json['taxAmount']),
        taxType: json['taxType'] as String?,
        taxModel: json['taxModel'] as String?,
        minOrderQty: Converter.toIntOrNull(json['minOrderQty']),
        maxOrderQty: Converter.toIntOrNull(json['maxOrderQty']),
        shippingCost: Converter.toDoubleOrNull(json['shippingCost']),
        multiplyShippingByQty: json['multiplyShippingByQty'] as bool?,
        refundable: json['refundable'] as bool?,
        cashOnDelivery: json['cashOnDelivery'] as bool?,
        isFeatured: json['isFeatured'] as bool?,
        requiresPrescription: json['requiresPrescription'] as bool?,
        status: json['status'] as String?,
        isActive: json['isActive'] as bool?,
        categoryId: json['categoryId'] as String?,
        brandId: json['brandId'] as String?,
        category: json['category'] != null
            ? ProductTaxonomy.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        brand: json['brand'] != null
            ? ProductTaxonomy.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        vendor: json['vendor'] != null
            ? ProductVendor.fromJson(json['vendor'] as Map<String, dynamic>)
            : null,
        averageRating: Converter.toDoubleOrNull(json['averageRating']),
        totalReviews: Converter.toIntOrNull(json['totalReviews']),
        seoMeta: json['seoMeta'] != null
            ? ProductSeoMeta.fromJson(json['seoMeta'] as Map<String, dynamic>)
            : null,
        image: json['image'] != null
            ? ProductImage.fromJson(json['image'] as Map<String, dynamic>)
            : null,
        images: (json['images'] as List?)
                ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        variants: (json['variants'] as List?)
                ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        variantsCount: Converter.toIntOrNull(json['variantsCount']),
        defaultVariant: json['defaultVariant'] != null
            ? ProductVariant.fromJson(json['defaultVariant'] as Map<String, dynamic>)
            : null,
        totalStock: Converter.toIntOrNull(json['totalStock']),
        price: Converter.toDoubleOrNull(json['price']),
        sellingPrice: Converter.toDoubleOrNull(json['sellingPrice']),
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'] as String)
            : null,
      );
}

/// The shared shape of `category` and `brand` on the details endpoint:
/// a localized name/slug plus an image (brands also carry a localized alt text).
class ProductTaxonomy {
  final String? id;
  final LocalizedText? name;
  final LocalizedText? slug;
  final String? image;
  final LocalizedText? imageAlt;

  ProductTaxonomy({this.id, this.name, this.slug, this.image, this.imageAlt});

  factory ProductTaxonomy.fromJson(Map<String, dynamic> json) => ProductTaxonomy(
    id: json['id'] as String?,
    name: LocalizedText.fromJson(json['name']),
    slug: LocalizedText.fromJson(json['slug']),
    image: json['image'] as String?,
    imageAlt: json['imageAlt'] != null
        ? LocalizedText.fromJson(json['imageAlt'])
        : null,
  );
}

class ProductSeoMeta {
  final LocalizedText? title;
  final LocalizedText? description;
  final String? image;

  ProductSeoMeta({this.title, this.description, this.image});

  factory ProductSeoMeta.fromJson(Map<String, dynamic> json) => ProductSeoMeta(
    title: LocalizedText.fromJson(json['title']),
    description: LocalizedText.fromJson(json['description']),
    image: json['image'] as String?,
  );
}
