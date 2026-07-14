import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../data/repos/notifications_repo.dart';
import 'notifications_state.dart';
import 'unread_notifications_cubit.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo notificationsRepo;
  static const _limit = 10;

  NotificationsCubit(this.notificationsRepo) : super(const NotificationsState());

  Future<void> getNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading, errorMessage: null));
    final result = await notificationsRepo.getInboxNotifications(page: 1, limit: _limit);
    result.fold(
      (failure) => emit(
        state.copyWith(status: NotificationsStatus.error, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          status: NotificationsStatus.loaded,
          notifications: page.items,
          page: 1,
          hasNext: page.hasNext,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext) return;

    emit(state.copyWith(status: NotificationsStatus.loadingMore));
    final nextPage = state.page + 1;
    final result = await notificationsRepo.getInboxNotifications(
      page: nextPage,
      limit: _limit,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: NotificationsStatus.loaded, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          status: NotificationsStatus.loaded,
          notifications: [...state.notifications, ...page.items],
          page: nextPage,
          hasNext: page.hasNext,
        ),
      ),
    );
  }

  Future<void> markAsRead(String id) async {
    final index = state.notifications.indexWhere((n) => n.id == id);
    if (index == -1 || state.notifications[index].isRead) return;

    final result = await notificationsRepo.markAsRead(id);
    result.fold((_) {}, (readAt) {
      final updated = [...state.notifications];
      updated[index] = updated[index].copyWith(readAt: readAt);
      emit(state.copyWith(notifications: updated));
      getIt<UnreadNotificationsCubit>().decrement();
    });
  }

  Future<void> markAllAsRead() async {
    if (state.notifications.every((n) => n.isRead)) return;

    final result = await notificationsRepo.markAllAsRead();
    result.fold((_) {}, (_) {
      final now = DateTime.now();
      final updated = state.notifications
          .map((n) => n.isRead ? n : n.copyWith(readAt: now))
          .toList();
      emit(state.copyWith(notifications: updated));
      getIt<UnreadNotificationsCubit>().reset();
    });
  }
}
