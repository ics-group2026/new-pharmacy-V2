import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/pill_chip.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import 'trending_product_item.dart';

class TrendingSection extends StatefulWidget {
  const TrendingSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  int _selectedFilter = 0;

  static const _filterKeys = [
    'trending.best_seller',
    'trending.top_rated',
    'trending.on_sale',
    'trending.new_arrivals',
  ];

  static const _products = [
    FlashDealModel(
      name: 'Organic High-Curcumin Turmeric Powder',
      price: 22.49,
      originalPrice: 32.0,
      discountPercent: 30,
      imageUrl: 'https://picsum.photos/seed/tr_a1/300/300',
      rating: 4.5,
    ),
    FlashDealModel(
      name: 'Aura Radiance Hydration Serum',
      price: 54.0,
      originalPrice: 72.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/tr_a2/300/300',
      rating: 4.0,
    ),
    FlashDealModel(
      name: 'Vitamin C 1000mg Effervescent',
      price: 89.0,
      originalPrice: 115.0,
      discountPercent: 23,
      imageUrl: 'https://picsum.photos/seed/tr_a3/300/300',
      rating: 5.0,
    ),
    FlashDealModel(
      name: 'MEDIDERM Dermatological Moisturizer',
      price: 106.0,
      originalPrice: 140.0,
      discountPercent: 24,
      imageUrl: 'https://picsum.photos/seed/tr_a4/300/300',
      rating: 3.5,
    ),
    FlashDealModel(
      name: 'Omega 3 Fish Oil 1200mg Softgels',
      price: 145.0,
      originalPrice: 190.0,
      discountPercent: 24,
      imageUrl: 'https://picsum.photos/seed/tr_a5/300/300',
      rating: 4.5,
    ),
    FlashDealModel(
      name: 'Biotin Hair Growth Formula',
      price: 120.0,
      originalPrice: 160.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/tr_a6/300/300',
      rating: 4.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(titleKey: 'trending.title', onSeeAll: widget.onSeeAll),
        12.verticalSpace,
        SizedBox(
          height: 44.h,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: _filterKeys.length,
            separatorBuilder: (_, _) => 8.horizontalSpace,
            itemBuilder: (_, index) => PillChip(
              label: AppTranslations.t(_filterKeys[index]),
              isSelected: _selectedFilter == index,
              onTap: () => setState(() => _selectedFilter = index),
            ),
          ),
        ),
        16.verticalSpace,
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: GridView.builder(
            key: ValueKey(_selectedFilter),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.65,
            ),
            itemCount: _products.length,
            itemBuilder: (_, index) => TrendingProductItem(product: _products[index]),
          ),
        ),
      ],
    );
  }
}
