import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/product_card.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class HomeProductItem extends StatelessWidget {
  const HomeProductItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: product, imageHeight: 130.h, width: 160.w, enableHero: false);
  }
}
