import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

import 'trending_product_item.dart';

/// Shared so the grid and its loading placeholder stay visually identical.
SliverGridDelegateWithFixedCrossAxisCount trendingGridDelegate() =>
    SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      mainAxisExtent: 265.h,
    );

class TrendingGrid extends StatelessWidget {
  const TrendingGrid({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: trendingGridDelegate(),
      itemCount: products.length,
      itemBuilder: (_, index) => TrendingProductItem(product: products[index]),
    );
  }
}
