import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';
import '../../data/models/combo_offer_product.dart';
import 'combo_offer_product_tile.dart';

class ComboOfferProductsList extends StatelessWidget {
  const ComboOfferProductsList({super.key, required this.products});

  final List<ComboOfferProduct> products;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTranslations.t('combo_offers.included_products'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        12.verticalSpace,
        ...products.map(
          (comboProduct) => ComboOfferProductTile(comboProduct: comboProduct),
        ),
      ],
    );
  }
}
