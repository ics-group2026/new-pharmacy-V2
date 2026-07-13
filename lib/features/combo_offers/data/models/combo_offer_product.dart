class ComboOfferProduct {
  final String id;
  final String comboOfferId;
  final String productId;
  final int quantity;
  final int sortOrder;
  final ComboOfferProductInfo product;

  ComboOfferProduct({
    required this.id,
    required this.comboOfferId,
    required this.productId,
    required this.quantity,
    required this.sortOrder,
    required this.product,
  });

  factory ComboOfferProduct.fromJson(Map<String, dynamic> json) => ComboOfferProduct(
    id: json['id'] as String,
    comboOfferId: json['comboOfferId'] as String,
    productId: json['productId'] as String,
    quantity: json['quantity'] as int,
    sortOrder: json['sortOrder'] as int,
    product: ComboOfferProductInfo.fromJson(json['product'] as Map<String, dynamic>),
  );
}

class ComboOfferProductInfo {
  final String id;
  final String name;
  final String? image;
  final String status;

  ComboOfferProductInfo({
    required this.id,
    required this.name,
    this.image,
    required this.status,
  });

  factory ComboOfferProductInfo.fromJson(Map<String, dynamic> json) =>
      ComboOfferProductInfo(
        id: json['id'] as String,
        name: json['name'] as String,
        image: json['image'] as String?,
        status: json['status'] as String,
      );
}
