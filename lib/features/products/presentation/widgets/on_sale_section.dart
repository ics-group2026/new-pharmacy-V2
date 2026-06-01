import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/title_with_see_all.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import 'home_product_item.dart';

class OnSaleSection extends StatelessWidget {
  const OnSaleSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    FlashDealModel(
      name: 'MEDIDERM Dermatological Moisturizer Lotion',
      price: 106.00,
      imageUrl: 'https://picsum.photos/seed/os1/200/200',
      rating: 4.0,
    ),
    FlashDealModel(
      name: 'Pectol Orange Throat Lozenges',
      price: 25.00,
      imageUrl: 'https://picsum.photos/seed/os2/200/200',
      rating: 3.5,
    ),
    FlashDealModel(
      name: 'Aurora Organic Cleansing Oil',
      price: 54.00,
      imageUrl: 'https://picsum.photos/seed/os3/200/200',
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithSeeAll(
          titleKey: 'products.on_sale',
          onSeeAll: onSeeAll ?? () {},
        ),
        4.verticalSpace,
        Container(
          width: AppTranslations.t('products.on_sale').length * 8.w,
          height: 2.5.h,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        12.verticalSpace,
        SizedBox(
          height: 230.h,
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
