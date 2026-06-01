import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/title_with_see_all.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import 'home_product_item.dart';

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    FlashDealModel(
      name: 'Vitamin C 1000mg Effervescent Tablets',
      price: 89.00,
      originalPrice: 115.0,
      discountPercent: 23,
      imageUrl: 'https://picsum.photos/seed/tr1/200/200',
      rating: 5.0,
    ),
    FlashDealModel(
      name: 'Omega 3 Fish Oil 1200mg Softgels',
      price: 145.00,
      originalPrice: 190.0,
      discountPercent: 24,
      imageUrl: 'https://picsum.photos/seed/tr2/200/200',
      rating: 4.5,
    ),
    FlashDealModel(
      name: 'Collagen Peptides Anti-Aging Complex',
      price: 210.00,
      originalPrice: 280.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/tr3/200/200',
      rating: 4.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithSeeAll(titleKey: 'products.top_rated', onSeeAll: onSeeAll ?? () {}),
        4.verticalSpace,
        Container(
          width: AppTranslations.t('products.top_rated').length * 8.w,
          height: 2.5.h,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        12.verticalSpace,
        SizedBox(
          height: 270.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _products.length,
            separatorBuilder: (_, _) => 12.horizontalSpace,
            itemBuilder: (_, index) => SizedBox(width: 150.w, child: HomeProductItem(product: _products[index])),
          ),
        ),
      ],
    );
  }
}
