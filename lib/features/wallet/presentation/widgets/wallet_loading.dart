import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Skeleton matching the loaded layout: hero card, segmented control, rows.
class WalletLoading extends StatelessWidget {
  const WalletLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final block = colorScheme.surfaceContainerHighest;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 168.h,
            decoration: BoxDecoration(
              color: block,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) 8.horizontalSpace,
                Container(
                  width: 104.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: block,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ],
            ],
          ),
          16.verticalSpace,
          for (var i = 0; i < 5; i++) ...[
            if (i > 0) 12.verticalSpace,
            Container(
              width: double.infinity,
              height: 76.h,
              decoration: BoxDecoration(
                color: block,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
