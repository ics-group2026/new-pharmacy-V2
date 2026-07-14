import '../../../../core/utils/converter.dart';

class FlashDealProduct {
  final String? id;
  final double? discountedPrice;
  final FlashDealProductInfo? product;

  FlashDealProduct({this.id, this.discountedPrice, this.product});

  factory FlashDealProduct.fromJson(Map<String, dynamic> json) => FlashDealProduct(
    id: json['id'] as String?,
    discountedPrice: Converter.toDoubleOrNull(json['discountedPrice']),
    product: json['product'] != null
        ? FlashDealProductInfo.fromJson(json['product'] as Map<String, dynamic>)
        : null,
  );
}

class FlashDealProductInfo {
  final String? id;
  final String? name;
  final String? image;
  final String? status;

  FlashDealProductInfo({this.id, this.name, this.image, this.status});

  factory FlashDealProductInfo.fromJson(Map<String, dynamic> json) =>
      FlashDealProductInfo(
        id: json['id'] as String?,
        name: json['name'] as String?,
        image: (json['image'] as Map<String, dynamic>?)?['url'] as String?,
        status: json['status'] as String?,
      );
}
