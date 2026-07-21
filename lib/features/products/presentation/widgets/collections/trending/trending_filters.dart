import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_collections.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/pill_chip.dart';

/// The filter chips map 1:1 onto the storefront presets, so selecting one
/// re-queries `GET /products?collection=...`.
const trendingFilters = <({String labelKey, String collection})>[
  (labelKey: 'trending.best_seller', collection: ProductCollections.bestSeller),
  (labelKey: 'trending.top_rated', collection: ProductCollections.topRated),
  (labelKey: 'trending.on_sale', collection: ProductCollections.onSale),
  (labelKey: 'trending.new_arrivals', collection: ProductCollections.newArrivals),
];

class TrendingFilters extends StatelessWidget {
  const TrendingFilters({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: trendingFilters.length,
        separatorBuilder: (_, _) => 8.horizontalSpace,
        itemBuilder: (_, index) => PillChip(
          label: AppTranslations.t(trendingFilters[index].labelKey),
          isSelected: selectedIndex == index,
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}
