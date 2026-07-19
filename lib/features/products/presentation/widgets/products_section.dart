import 'package:flutter/material.dart';

import 'product_collection_section.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return ProductCollectionSection(
      titleKey: 'products.all_products',
      onSeeAll: onSeeAll,
    );
  }
}
