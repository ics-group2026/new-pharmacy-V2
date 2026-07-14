import '../../data/models/notification_model.dart';

enum NotificationsStatus { initial, loading, loadingMore, loaded, error }

class NotificationsState {
  final NotificationsStatus status;
  final List<NotificationModel> notifications;
  final int page;
  final bool hasNext;
  final String? errorMessage;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.page = 1,
    this.hasNext = false,
    this.errorMessage,
  });

  bool get isLoading => status == NotificationsStatus.loading;
  bool get isLoadingMore => status == NotificationsStatus.loadingMore;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationModel>? notifications,
    int? page,
    bool? hasNext,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
      errorMessage: errorMessage,
    );
  }
}
