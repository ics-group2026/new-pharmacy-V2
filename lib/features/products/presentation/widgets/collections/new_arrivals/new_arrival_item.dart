import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_pharmacy_v2/core/widgets/product_card.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class NewArrivalItem extends StatelessWidget {
  const NewArrivalItem({super.key, required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: item, imageHeight: 140.h, width: 160.w);
  }
}
