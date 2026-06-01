import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_translations.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const white = Colors.white;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      floating: false,
      toolbarHeight: 76.h,
      titleSpacing: 16.w,
      backgroundColor: colorScheme.primary.withValues(alpha: 0.82),
      title: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withValues(alpha: 0.2),
              border: Border.all(color: white.withValues(alpha: 0.5), width: 1.5),
            ),
            child: Icon(Icons.person_rounded, color: white, size: 20.r),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTranslations.t('home.greeting'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: white.withValues(alpha: 0.75),
                  ),
                ),
                2.verticalSpace,
                Text(
                  AppTranslations.t('home.user_name'),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: white,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          _NotificationButton(),
          12.horizontalSpace,
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(9.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.notifications_outlined, size: 20.r, color: Colors.white),
        ),
        Positioned(
          top: 7.r,
          right: 7.r,
          child: Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
