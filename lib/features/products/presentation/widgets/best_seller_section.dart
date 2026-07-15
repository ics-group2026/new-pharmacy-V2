import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/section_header.dart';
import '../../data/models/product_image.dart';
import '../../data/models/product_model.dart';
import 'home_product_item.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    ProductModel(
      id: 'demo-bs-1',
      name: 'Organic High-Curcumin Turmeric Powder',
      price: 32.0,
      sellingPrice: 22.49,
      image: ProductImage(url: 'https://picsum.photos/seed/bs1/200/200'),
    ),
    ProductModel(
      id: 'demo-bs-2',
      name: 'Pure Medical Grade Hyaluronic Serum',
      price: 60.0,
      sellingPrice: 45.00,
      image: ProductImage(url: 'https://picsum.photos/seed/bs2/200/200'),
    ),
    ProductModel(
      id: 'demo-bs-3',
      name: 'Advanced Daytime Face Moisturizer',
      price: 45.0,
      sellingPrice: 32.99,
      image: ProductImage(url: 'https://picsum.photos/seed/bs3/200/200'),
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
