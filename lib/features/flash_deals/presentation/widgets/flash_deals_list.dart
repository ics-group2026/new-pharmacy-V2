import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/flash_deal_model.dart';
import 'flash_deal_card.dart';

class FlashDealsList extends StatelessWidget {
  const FlashDealsList({super.key, required this.flashDeals});

  final List<FlashDealModel> flashDeals;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: flashDeals.length,
      separatorBuilder: (_, _) => 12.horizontalSpace,
      itemBuilder: (_, index) => FlashDealCard(
        flashDeal: flashDeals[index],
        width: 170.w,
        imageHeight: 130.h,
      ),
    );
  }
}
