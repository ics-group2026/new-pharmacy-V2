import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandsLoading extends StatelessWidget {
  const BrandsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      itemCount: 5,
      separatorBuilder: (_, _) => 16.horizontalSpace,
      itemBuilder: (_, _) => const _BrandCircleShimmer(),
    );
  }
}

class _BrandCircleShimmer extends StatelessWidget {
  const _BrandCircleShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 60.r,
      height: 60.r,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
    );
  }
}
