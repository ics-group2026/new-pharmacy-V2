import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/section_header.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(titleKey: 'products.best_seller', onSeeAll: onSeeAll),
        12.verticalSpace,
        IntrinsicHeight(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < _products.length; i++) ...[
                  if (i > 0) 12.horizontalSpace,
                  HomeProductItem(product: _products[i]),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
