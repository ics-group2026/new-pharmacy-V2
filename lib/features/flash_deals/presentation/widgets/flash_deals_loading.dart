import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlashDealsLoading extends StatelessWidget {
  const FlashDealsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (_, _) => 12.horizontalSpace,
      itemBuilder: (_, _) => const _FlashDealCardShimmer(),
    );
  }
}

class _FlashDealCardShimmer extends StatelessWidget {
  const _FlashDealCardShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
