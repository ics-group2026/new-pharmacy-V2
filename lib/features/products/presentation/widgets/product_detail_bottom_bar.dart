import 'package:flutter/material.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/add_to_cart_bar.dart';

class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final unitPrice = product.sellingPrice ?? product.price ?? 0;
    return AddToCartBar(
      totalPrice: unitPrice,
      currency: AppTranslations.t('flash_deals.currency'),
      // Cart cubit was removed; button stays for the UI shell but doesn't
      // add anything yet.
      onAddToCart: () {},
    );
  }
}
