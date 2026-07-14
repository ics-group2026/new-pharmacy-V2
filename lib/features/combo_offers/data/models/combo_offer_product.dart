import '../../../../core/utils/converter.dart';

class ComboOfferProduct {
  final String? id;
  final String? comboOfferId;
  final String? productId;
  final int? quantity;
  final int? sortOrder;
  final ComboOfferProductInfo? product;

  ComboOfferProduct({
    this.id,
    this.comboOfferId,
    this.productId,
    this.quantity,
    this.sortOrder,
    this.product,
  });

  factory ComboOfferProduct.fromJson(Map<String, dynamic> json) => ComboOfferProduct(
    id: json['id'] as String?,
    comboOfferId: json['comboOfferId'] as String?,
    productId: json['productId'] as String?,
    quantity: Converter.toIntOrNull(json['quantity']),
    sortOrder: Converter.toIntOrNull(json['sortOrder']),
    product: json['product'] != null
        ? ComboOfferProductInfo.fromJson(json['product'] as Map<String, dynamic>)
        : null,
  );
}

class ComboOfferProductInfo {
  final String? id;
  final String? name;
  final String? image;
  final String? status;

  ComboOfferProductInfo({this.id, this.name, this.image, this.status});

  factory ComboOfferProductInfo.fromJson(Map<String, dynamic> json) =>
      ComboOfferProductInfo(
        id: json['id'] as String?,
        name: json['name'] as String?,
        image: (json['image'] as Map<String, dynamic>?)?['url'] as String?,
        status: json['status'] as String?,
      );
}
