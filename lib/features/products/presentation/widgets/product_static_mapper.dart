import 'package:new_pharmacy_v2/core/models/static_product.dart';

import '../../data/models/product_model.dart';


extension ProductModelUiMapper on ProductModel {
  StaticProduct toStaticProduct() {
    return StaticProduct(
      name: name ?? '',
      price: sellingPrice ?? price ?? 0,
      originalPrice: hasDiscount ? price : null,
      discountPercent: discountPercent,
      imageUrl: image?.url ?? '',
      rating: null,
    );
  }
}
