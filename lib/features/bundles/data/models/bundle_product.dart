class BundleProduct {
  final String? id;
  final String? bundleId;
  final String? productId;
  final int? quantity;
  final int? sortOrder;
  final BundleProductInfo? product;

  BundleProduct({
    this.id,
    this.bundleId,
    this.productId,
    this.quantity,
    this.sortOrder,
    this.product,
  });

  factory BundleProduct.fromJson(Map<String, dynamic> json) => BundleProduct(
    id: json['id'] as String?,
    bundleId: json['bundleId'] as String?,
    productId: json['productId'] as String?,
    quantity: json['quantity'] as int?,
    sortOrder: json['sortOrder'] as int?,
    product: json['product'] != null
        ? BundleProductInfo.fromJson(json['product'] as Map<String, dynamic>)
        : null,
  );
}

class BundleProductInfo {
  final String? id;
  final String? name;
  final String? image;
  final String? status;

  BundleProductInfo({this.id, this.name, this.image, this.status});

  factory BundleProductInfo.fromJson(Map<String, dynamic> json) =>
      BundleProductInfo(
        id: json['id'] as String?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        status: json['status'] as String?,
      );
}
