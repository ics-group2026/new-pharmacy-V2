import 'package:flutter/material.dart';

import '../../../../data/models/product_collections.dart';
import '../../product_collection_section.dart';

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return ProductCollectionSection(
      titleKey: 'products.top_rated',
      collection: ProductCollections.topRated,
      onSeeAll: onSeeAll,
    );
  }
}
