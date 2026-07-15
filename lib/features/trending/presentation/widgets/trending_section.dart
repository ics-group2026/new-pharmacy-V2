import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/pill_chip.dart';
import '../../../../../core/widgets/section_header.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_image.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
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
    ProductModel(
      id: 'demo-tnd-1',
      name: 'Organic High-Curcumin Turmeric Powder',
      price: 32.0,
      sellingPrice: 22.49,
      image: ProductImage(url: 'https://picsum.photos/seed/tr_a1/300/300'),
    ),
    ProductModel(
      id: 'demo-tnd-2',
      name: 'Aura Radiance Hydration Serum',
      price: 72.0,
      sellingPrice: 54.0,
      image: ProductImage(url: 'https://picsum.photos/seed/tr_a2/300/300'),
    ),
    ProductModel(
      id: 'demo-tnd-3',
      name: 'Vitamin C 1000mg Effervescent',
      price: 115.0,
      sellingPrice: 89.0,
      image: ProductImage(url: 'https://picsum.photos/seed/tr_a3/300/300'),
    ),
    ProductModel(
      id: 'demo-tnd-4',
      name: 'MEDIDERM Dermatological Moisturizer',
      price: 140.0,
      sellingPrice: 106.0,
      image: ProductImage(url: 'https://picsum.photos/seed/tr_a4/300/300'),
    ),
    ProductModel(
      id: 'demo-tnd-5',
      name: 'Omega 3 Fish Oil 1200mg Softgels',
      price: 190.0,
      sellingPrice: 145.0,
      image: ProductImage(url: 'https://picsum.photos/seed/tr_a5/300/300'),
    ),
    ProductModel(
      id: 'demo-tnd-6',
      name: 'Biotin Hair Growth Formula',
      price: 160.0,
      sellingPrice: 120.0,
      image: ProductImage(url: 'https://picsum.photos/seed/tr_a6/300/300'),
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
