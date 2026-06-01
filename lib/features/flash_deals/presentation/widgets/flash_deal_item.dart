import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/product_card.dart';
import '../../data/models/flash_deal_model.dart';

class FlashDealItem extends StatelessWidget {
  const FlashDealItem({super.key, required this.deal});

  final FlashDealModel deal;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: deal, imageHeight: 140.h, width: 160.w);
  }
}
