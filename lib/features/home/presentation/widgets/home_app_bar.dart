import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/hero_tags.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/services/setup_service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/search_field_bar.dart';
import '../../../notifications/presentation/cubits/unread_notifications_cubit.dart';
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
                  buildWhen: (previous, current) =>
                      previous.user != current.user,
                  builder: (context, state) {
                    final user = state.user;
                    final hasName =
                        user != null &&
                        (user.firstName.isNotEmpty ||
                            user.lastName.isNotEmpty);
                    if (!hasName) {
                      // Skeleton while the profile loads — avoids flashing a
                      // placeholder name before the real one arrives.
                      return Container(
                        width: 120.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      );
                    }
                    return Text(
                      '${user.firstName} ${user.lastName}'.trim(),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: Hero(
        tag: HeroTags.searchBar,
        child: SearchFieldBar(
          interactive: false,
          onTap: () => context.push(AppRoutes.search),
        ),
      ),
    );
  }
}

class _NotificationButton extends StatefulWidget {
  const _NotificationButton();

  @override
  State<_NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<_NotificationButton> {
  late final UnreadNotificationsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<UnreadNotificationsCubit>()..getUnreadCount();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () async {
        await context.push(AppRoutes.notifications);
        if (context.mounted) _cubit.getUnreadCount();
      },
      child: BlocBuilder<UnreadNotificationsCubit, int>(
        bloc: _cubit,
        builder: (context, unreadCount) {
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
              if (unreadCount > 0)
                Positioned(
                  top: -2.r,
                  right: -2.r,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.r),
                    constraints: BoxConstraints(minWidth: 16.r, minHeight: 16.r),
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.primary, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 9 ? '9+' : '$unreadCount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onError,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
