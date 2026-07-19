import 'package:flutter/material.dart';

import '../../data/models/product_collections.dart';
import 'product_collection_section.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return ProductCollectionSection(
      titleKey: 'products.best_seller',
      collection: ProductCollections.bestSeller,
      onSeeAll: onSeeAll,
    );
  }
}
