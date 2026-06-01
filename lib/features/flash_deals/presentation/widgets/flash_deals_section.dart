import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/title_with_see_all.dart';
import '../../data/models/flash_deal_model.dart';
import 'flash_deal_item.dart';

class FlashDealsSection extends StatelessWidget {
  const FlashDealsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _deals = [
    FlashDealModel(
      name: 'Gastrotidine 2ml 3amp',
      price: 54.0,
      imageUrl: 'https://picsum.photos/seed/deal1/300/300',
    ),
    FlashDealModel(
      name: 'ANAFRONIL SR 75MG Tablet',
      price: 106.0,
      imageUrl: 'https://picsum.photos/seed/deal2/300/300',
    ),
    FlashDealModel(
      name: 'Pectol Lozenges Orange',
      price: 25.0,
      imageUrl: 'https://picsum.photos/seed/deal3/300/300',
    ),
    FlashDealModel(
      name: 'RIVO 10TAB',
      price: 200.0,
      imageUrl: 'https://picsum.photos/seed/deal4/300/300',
    ),
    FlashDealModel(
      name: 'Vitamin C 1000mg Effervescent',
      price: 89.0,
      imageUrl: 'https://picsum.photos/seed/deal5/300/300',
    ),
    FlashDealModel(
      name: 'Omega 3 Fish Oil 1200mg',
      price: 145.0,
      imageUrl: 'https://picsum.photos/seed/deal6/300/300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.verticalSpace,
          TitleWithSeeAll(
            titleKey: 'flash_deals.title',
            onSeeAll: onSeeAll ?? () {},
          ),
          16.verticalSpace,
          SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _deals.length,
              separatorBuilder: (_, _) => 12.horizontalSpace,
              itemBuilder: (_, index) => FlashDealItem(deal: _deals[index]),
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }
}
