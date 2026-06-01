import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/title_with_see_all.dart';
import '../../../flash_deals/data/models/flash_deal_model.dart';
import 'new_arrival_item.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _items = [
    FlashDealModel(
      name: 'Aura Radiance Hydration Serum',
      price: 54.0,
      imageUrl: 'https://picsum.photos/seed/na1/300/300',
    ),
    FlashDealModel(
      name: 'MEDIDERM Dermatological Moisturizer',
      price: 106.0,
      imageUrl: 'https://picsum.photos/seed/na2/300/300',
    ),
    FlashDealModel(
      name: 'Aurora Organic Cleansing Oil',
      price: 25.0,
      imageUrl: 'https://picsum.photos/seed/na3/300/300',
    ),
    FlashDealModel(
      name: 'RIVO 10TAB Supplement',
      price: 200.0,
      imageUrl: 'https://picsum.photos/seed/na4/300/300',
    ),
    FlashDealModel(
      name: 'Zinc & Magnesium Complex',
      price: 75.0,
      imageUrl: 'https://picsum.photos/seed/na5/300/300',
    ),
    FlashDealModel(
      name: 'Biotin Hair Growth Formula',
      price: 120.0,
      imageUrl: 'https://picsum.photos/seed/na6/300/300',
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
            titleKey: 'new_arrivals.title',
            onSeeAll: onSeeAll ?? () {},
          ),
          16.verticalSpace,
          SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _items.length,
              separatorBuilder: (_, _) => 12.horizontalSpace,
              itemBuilder: (_, index) => NewArrivalItem(item: _items[index]),
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }
}
