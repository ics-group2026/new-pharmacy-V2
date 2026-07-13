import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';
import '../../data/models/bundle_product.dart';
import 'bundle_product_tile.dart';

class BundleProductsList extends StatelessWidget {
  const BundleProductsList({super.key, required this.products});

  final List<BundleProduct> products;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTranslations.t('bundles.included_products'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        12.verticalSpace,
        ...products.map(
          (bundleProduct) => BundleProductTile(bundleProduct: bundleProduct),
        ),
      ],
    );
  }
}
