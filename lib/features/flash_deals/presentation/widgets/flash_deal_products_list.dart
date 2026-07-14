import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';
import '../../data/models/flash_deal_product.dart';
import 'flash_deal_product_tile.dart';

class FlashDealProductsList extends StatelessWidget {
  const FlashDealProductsList({super.key, required this.products});

  final List<FlashDealProduct> products;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTranslations.t('flash_deals.included_products'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        12.verticalSpace,
        // Deals can go live before products are attached, so say so rather
        // than leaving a blank gap under the heading.
        if (products.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              AppTranslations.t('flash_deals.no_products'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          )
        else
          ...products.map(
            (dealProduct) => FlashDealProductTile(dealProduct: dealProduct),
          ),
      ],
    );
  }
}
