import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'trending_grid.dart';

class TrendingGridLoading extends StatelessWidget {
  const TrendingGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: trendingGridDelegate(),
      itemCount: 4,
      itemBuilder: (_, _) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
