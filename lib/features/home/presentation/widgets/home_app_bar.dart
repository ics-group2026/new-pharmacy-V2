import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../profile/presentation/cubits/profile_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const white = Colors.white;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false,
      snap: false,
      toolbarHeight: 64.h,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDark, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withValues(alpha: 0.18),
              border: Border.all(
                color: white.withValues(alpha: 0.45),
                width: 1.5,
              ),
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
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final user = state.user;
                    final name =
                        user != null &&
                            (user.firstName.isNotEmpty ||
                                user.lastName.isNotEmpty)
                        ? '${user.firstName} ${user.lastName}'.trim()
                        : AppTranslations.t('home.user_name');
                    return Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: white,
                        height: 1.1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          _NotificationButton(),
          8.horizontalSpace,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: _SearchBarSlot(),
      ),
    );
  }
}

class _SearchBarSlot extends StatelessWidget {
  const _SearchBarSlot();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.search),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20.r,
                color: colorScheme.onSurface.withValues(alpha: 0.45),
              ),
              10.horizontalSpace,
              Text(
                AppTranslations.t('common.search_hint'),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ),
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
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_outlined,
            size: 20.r,
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 6.r,
          right: 6.r,
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
