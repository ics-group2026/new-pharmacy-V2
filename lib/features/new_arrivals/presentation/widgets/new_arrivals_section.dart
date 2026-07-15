import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/section_header.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_image.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'new_arrival_item.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _items = [
    ProductModel(
      id: 'demo-na-1',
      name: 'Aura Radiance Hydration Serum',
      price: 54.0,
      image: ProductImage(url: 'https://picsum.photos/seed/na1/300/300'),
    ),
    ProductModel(
      id: 'demo-na-2',
      name: 'MEDIDERM Dermatological Moisturizer',
      price: 106.0,
      image: ProductImage(url: 'https://picsum.photos/seed/na2/300/300'),
    ),
    ProductModel(
      id: 'demo-na-3',
      name: 'Aurora Organic Cleansing Oil',
      price: 25.0,
      image: ProductImage(url: 'https://picsum.photos/seed/na3/300/300'),
    ),
    ProductModel(
      id: 'demo-na-4',
      name: 'RIVO 10TAB Supplement',
      price: 200.0,
      image: ProductImage(url: 'https://picsum.photos/seed/na4/300/300'),
    ),
    ProductModel(
      id: 'demo-na-5',
      name: 'Zinc & Magnesium Complex',
      price: 75.0,
      image: ProductImage(url: 'https://picsum.photos/seed/na5/300/300'),
    ),
    ProductModel(
      id: 'demo-na-6',
      name: 'Biotin Hair Growth Formula',
      price: 120.0,
      image: ProductImage(url: 'https://picsum.photos/seed/na6/300/300'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(titleKey: 'new_arrivals.title', onSeeAll: onSeeAll),
          12.verticalSpace,
          SizedBox(
            height: 270.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: _items.length,
              separatorBuilder: (_, _) => 12.horizontalSpace,
              itemBuilder: (_, index) => NewArrivalItem(item: _items[index]),
            ),
          ),
        ],
      ),
    );
  }
}
