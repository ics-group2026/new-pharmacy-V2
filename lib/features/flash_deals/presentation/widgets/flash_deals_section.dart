import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';
import '../../data/models/flash_deal_model.dart';
import 'flash_deal_item.dart';

class FlashDealsSection extends StatelessWidget {
  const FlashDealsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  static const _deals = [
    FlashDealModel(
      name: 'Gastrotidine 2ml 3amp',
      price: 54.0,
      originalPrice: 72.0,
      discountPercent: 25,
      imageUrl: 'https://picsum.photos/seed/deal1/300/300',
    ),
    FlashDealModel(
      name: 'ANAFRONIL SR 75MG Tablet',
      price: 106.0,
      originalPrice: 130.0,
      discountPercent: 18,
      imageUrl: 'https://picsum.photos/seed/deal2/300/300',
    ),
    FlashDealModel(
      name: 'Pectol Lozenges Orange',
      price: 25.0,
      originalPrice: 35.0,
      discountPercent: 28,
      imageUrl: 'https://picsum.photos/seed/deal3/300/300',
    ),
    FlashDealModel(
      name: 'RIVO 10TAB',
      price: 200.0,
      originalPrice: 240.0,
      discountPercent: 17,
      imageUrl: 'https://picsum.photos/seed/deal4/300/300',
    ),
    FlashDealModel(
      name: 'Vitamin C 1000mg Effervescent',
      price: 89.0,
      originalPrice: 115.0,
      discountPercent: 22,
      imageUrl: 'https://picsum.photos/seed/deal5/300/300',
    ),
    FlashDealModel(
      name: 'Omega 3 Fish Oil 1200mg',
      price: 145.0,
      originalPrice: 180.0,
      discountPercent: 19,
      imageUrl: 'https://picsum.photos/seed/deal6/300/300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.verticalSpace,
          _FlashDealsHeader(onSeeAll: onSeeAll),
          16.verticalSpace,
          SizedBox(
            height: 230.h,
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

class _FlashDealsHeader extends StatelessWidget {
  const _FlashDealsHeader({this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(Icons.bolt_rounded, color: const Color(0xFFFFC107), size: 20.r),
        ),
        8.horizontalSpace,
        Expanded(
          child: Text(
            AppTranslations.t('flash_deals.title'),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        _CountdownTimer(),
        12.horizontalSpace,
        GestureDetector(
          onTap: onSeeAll ?? () {},
          child: Row(
            children: [
              Text(
                AppTranslations.t('common.see_all'),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              2.horizontalSpace,
              Icon(Icons.arrow_forward_ios_rounded, size: 11.r, color: colorScheme.primary),
            ],
          ),
        ),
      ],
    );
  }
}

class _CountdownTimer extends StatelessWidget {
  const _CountdownTimer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TimeSegment('23'),
        _Colon(),
        _TimeSegment('45'),
        _Colon(),
        _TimeSegment('12'),
      ],
    );
  }
}

class _TimeSegment extends StatelessWidget {
  const _TimeSegment(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colorScheme.onSurface,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.surface,
        ),
      ),
    );
  }
}

class _Colon extends StatelessWidget {
  const _Colon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
