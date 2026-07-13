import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComboOffersLoading extends StatelessWidget {
  const ComboOffersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (_, _) => 12.horizontalSpace,
      itemBuilder: (_, _) => const _ComboOfferCardShimmer(),
    );
  }
}

class _ComboOfferCardShimmer extends StatelessWidget {
  const _ComboOfferCardShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
