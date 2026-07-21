import '../../data/models/product_details_model.dart';
import '../../data/models/product_model.dart';

extension ProductDetailsMapper on ProductDetailsModel {
  /// Reduces the full details record to the [ProductModel] the shared product
  /// widgets render, resolving localized text for [languageCode]. Rating,
  /// description and the image gallery are passed to the detail widgets
  /// separately since [ProductModel] does not carry them.
  ProductModel toProductModel(String languageCode) {
    return ProductModel(
      id: id,
      name: name?.localized(languageCode),
      price: price,
      sellingPrice: sellingPrice,
      image: image ?? (images.isNotEmpty ? images.first : null),
      totalStock: totalStock,
      productType: productType,
      categoryId: categoryId,
      brandId: brandId,
      vendor: vendor,
    );
  }
}
