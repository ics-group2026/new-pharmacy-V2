import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/section_header.dart';
import '../../data/models/product_image.dart';
import '../../data/models/product_model.dart';
import 'home_product_item.dart';

class OnSaleSection extends StatelessWidget {
  const OnSaleSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _products = [
    ProductModel(
      id: 'demo-os-1',
      name: 'MEDIDERM Dermatological Moisturizer Lotion',
      price: 140.0,
      sellingPrice: 106.00,
      image: ProductImage(url: 'https://picsum.photos/seed/os1/200/200'),
    ),
    ProductModel(
      id: 'demo-os-2',
      name: 'Pectol Orange Throat Lozenges',
      price: 38.0,
      sellingPrice: 25.00,
      image: ProductImage(url: 'https://picsum.photos/seed/os2/200/200'),
    ),
    ProductModel(
      id: 'demo-os-3',
      name: 'Aurora Organic Cleansing Oil',
      price: 75.0,
      sellingPrice: 54.00,
      image: ProductImage(url: 'https://picsum.photos/seed/os3/200/200'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(titleKey: 'products.on_sale', onSeeAll: onSeeAll),
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
