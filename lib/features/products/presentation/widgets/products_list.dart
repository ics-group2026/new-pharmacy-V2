import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/product_model.dart';
import 'home_product_item.dart';
import 'product_static_mapper.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight lets the row size to the tallest card, so a product name
    // wrapping to two lines never overflows a fixed height.
    return IntrinsicHeight(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < products.length; i++) ...[
              if (i > 0) 12.horizontalSpace,
              HomeProductItem(product: products[i].toStaticProduct()),
            ],
          ],
        ),
      ),
    );
  }
}
