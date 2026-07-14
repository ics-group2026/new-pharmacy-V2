import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../data/repos/notifications_repo.dart';
import '../cubits/notifications_cubit.dart';
import '../cubits/notifications_state.dart';
import '../widgets/notification_item_tile.dart';
import '../widgets/notifications_loading.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationsCubit(getIt<NotificationsRepo>())..getNotifications(),
      child: const _NotificationsBody(),
    );
  }
}

class _NotificationsBody extends StatefulWidget {
  const _NotificationsBody();

  @override
  State<_NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<_NotificationsBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.t('account.notifications')),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            buildWhen: (previous, current) =>
                previous.notifications != current.notifications,
            builder: (context, state) {
              final hasUnread = state.notifications.any((n) => !n.isRead);
              if (!hasUnread) return const SizedBox.shrink();
              return TextButton(
                onPressed: () => context.read<NotificationsCubit>().markAllAsRead(),
                child: Text(AppTranslations.t('notifications.mark_all_read')),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading ||
              state.status == NotificationsStatus.initial) {
            return const NotificationsLoading();
          }

          if (state.status == NotificationsStatus.error &&
              state.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errorMessage ?? AppTranslations.t('common.no_data'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  12.verticalSpace,
                  TextButton(
                    onPressed: () => context.read<NotificationsCubit>().getNotifications(),
                    child: Text(AppTranslations.t('common.retry')),
                  ),
                ],
              ),
            );
          }

          if (state.notifications.isEmpty) {
            return const EmptyDataPlaceholder();
          }

          return RefreshIndicator(
            onRefresh: () => context.read<NotificationsCubit>().getNotifications(),
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.all(16.r),
              itemCount:
                  state.notifications.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, _) => 12.verticalSpace,
              itemBuilder: (context, index) {
                if (index >= state.notifications.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                final item = state.notifications[index];
                return NotificationItemTile(
                  notification: item,
                  onTap: item.id != null
                      ? () => context.read<NotificationsCubit>().markAsRead(item.id!)
                      : null,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
