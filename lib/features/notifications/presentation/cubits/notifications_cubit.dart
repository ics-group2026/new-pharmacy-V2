import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/notifications_repo.dart';
import 'notifications_state.dart';

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
}
