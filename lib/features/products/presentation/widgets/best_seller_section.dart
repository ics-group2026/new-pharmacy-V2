import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/title_with_see_all.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import 'home_product_item.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    FlashDealModel(
      name: 'Organic High-Curcumin Turmeric Powder',
      price: 22.49,
      originalPrice: 32.0,
      discountPercent: 30,
      imageUrl: 'https://picsum.photos/seed/bs1/200/200',
      rating: 4.5,
    ),
    FlashDealModel(
      name: 'Pure Medical Grade Hyaluronic Serum',
      price: 45.00,
      originalPrice: 60.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/bs2/200/200',
      rating: 3.5,
    ),
    FlashDealModel(
      name: 'Advanced Daytime Face Moisturizer',
      price: 32.99,
      originalPrice: 45.0,
      discountPercent: 27,
      imageUrl: 'https://picsum.photos/seed/bs3/200/200',
      rating: 5.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithSeeAll(
          titleKey: 'products.best_seller',
          onSeeAll: onSeeAll ?? () {},
        ),
        4.verticalSpace,
        Container(
          width: AppTranslations.t('products.best_seller').length * 7.w,
          height: 2.h,
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
