import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsLoading extends StatelessWidget {
  const ProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        itemCount: 4,
        separatorBuilder: (_, _) => 12.horizontalSpace,
        itemBuilder: (_, _) => const _ProductCardShimmer(),
      ),
    );
  }
}

class _ProductCardShimmer extends StatelessWidget {
  const _ProductCardShimmer();

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
