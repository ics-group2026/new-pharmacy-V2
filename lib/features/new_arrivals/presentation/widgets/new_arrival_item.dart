import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/product_card.dart';
import 'package:new_pharmacy_v2/core/models/static_product.dart';

class NewArrivalItem extends StatelessWidget {
  const NewArrivalItem({super.key, required this.item});

  final StaticProduct item;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: item, imageHeight: 140.h, width: 160.w);
  }
}
