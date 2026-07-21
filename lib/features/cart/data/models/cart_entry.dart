import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class CartEntry {
  const CartEntry({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;
}
