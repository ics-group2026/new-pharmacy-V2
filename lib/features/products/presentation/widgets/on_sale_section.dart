import 'package:flutter/material.dart';

import '../../data/models/product_collections.dart';
import 'product_collection_section.dart';

class OnSaleSection extends StatelessWidget {
  const OnSaleSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return ProductCollectionSection(
      titleKey: 'products.on_sale',
      collection: ProductCollections.onSale,
      onSeeAll: onSeeAll,
    );
  }
}
