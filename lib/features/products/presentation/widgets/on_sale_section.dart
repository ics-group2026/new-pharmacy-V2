import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/section_header.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import 'home_product_item.dart';

class OnSaleSection extends StatelessWidget {
  const OnSaleSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    FlashDealModel(
      name: 'MEDIDERM Dermatological Moisturizer Lotion',
      price: 106.00,
      originalPrice: 140.0,
      discountPercent: 24,
      imageUrl: 'https://picsum.photos/seed/os1/200/200',
      rating: 4.0,
    ),
    FlashDealModel(
      name: 'Pectol Orange Throat Lozenges',
      price: 25.00,
      originalPrice: 38.0,
      discountPercent: 34,
      imageUrl: 'https://picsum.photos/seed/os2/200/200',
      rating: 3.5,
    ),
    FlashDealModel(
      name: 'Aurora Organic Cleansing Oil',
      price: 54.00,
      originalPrice: 75.0,
      discountPercent: 28,
      imageUrl: 'https://picsum.photos/seed/os3/200/200',
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(titleKey: 'products.on_sale', onSeeAll: onSeeAll),
        12.verticalSpace,
        SizedBox(
          height: 270.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: _products.length,
            separatorBuilder: (_, _) => 12.horizontalSpace,
            itemBuilder: (_, index) => HomeProductItem(product: _products[index]),
          ),
        ),
      ],
    );
  }
}
