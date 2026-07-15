import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/section_header.dart';
import '../../data/models/product_image.dart';
import '../../data/models/product_model.dart';
import 'home_product_item.dart';

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    ProductModel(
      id: 'demo-tr-1',
      name: 'Vitamin C 1000mg Effervescent Tablets',
      price: 115.0,
      sellingPrice: 89.00,
      image: ProductImage(url: 'https://picsum.photos/seed/tr1/200/200'),
    ),
    ProductModel(
      id: 'demo-tr-2',
      name: 'Omega 3 Fish Oil 1200mg Softgels',
      price: 190.0,
      sellingPrice: 145.00,
      image: ProductImage(url: 'https://picsum.photos/seed/tr2/200/200'),
    ),
    ProductModel(
      id: 'demo-tr-3',
      name: 'Collagen Peptides Anti-Aging Complex',
      price: 280.0,
      sellingPrice: 210.00,
      image: ProductImage(url: 'https://picsum.photos/seed/tr3/200/200'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(titleKey: 'products.top_rated', onSeeAll: onSeeAll),
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
