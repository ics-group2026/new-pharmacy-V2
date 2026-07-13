import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/combo_offer_model.dart';
import 'combo_offer_card.dart';

class ComboOffersList extends StatelessWidget {
  const ComboOffersList({super.key, required this.comboOffers});

  final List<ComboOfferModel> comboOffers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: comboOffers.length,
      separatorBuilder: (_, _) => 12.horizontalSpace,
      itemBuilder: (_, index) => ComboOfferCard(
        comboOffer: comboOffers[index],
        width: 160.w,
        imageHeight: 140.h,
      ),
    );
  }
}
