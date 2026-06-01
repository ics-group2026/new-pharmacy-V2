import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/product_card.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';

class NewArrivalItem extends StatelessWidget {
  const NewArrivalItem({super.key, required this.item});

  final FlashDealModel item;

  @override
  Widget build(BuildContext context) {
    return ProductCard(product: item, imageHeight: 140.h, width: 160.w);
  }
}
