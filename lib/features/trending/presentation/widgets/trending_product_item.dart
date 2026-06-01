import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/product_card.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';

class TrendingProductItem extends StatelessWidget {
  const TrendingProductItem({super.key, required this.product});

  final FlashDealModel product;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: product, imageHeight: 110.h);
  }
}
