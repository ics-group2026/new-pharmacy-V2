import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsLoading extends StatelessWidget {
  const NotificationsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: 6,
      separatorBuilder: (_, _) => 12.verticalSpace,
      itemBuilder: (_, _) => const _NotificationTileShimmer(),
    );
  }
}

class _NotificationTileShimmer extends StatelessWidget {
  const _NotificationTileShimmer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 76.h,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}
