import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/product_card.dart';
import 'package:new_pharmacy_v2/core/models/static_product.dart';

class HomeProductItem extends StatelessWidget {
  const HomeProductItem({super.key, required this.product});

  final StaticProduct product;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: product, imageHeight: 130.h, width: 160.w);
  }
}
