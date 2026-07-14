import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/converter.dart';
import '../models/notification_model.dart';
import 'notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  final ApiService apiService;
  NotificationsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, ({List<NotificationModel> items, bool hasNext})>>
  getInboxNotifications({int page = 1, int limit = 10}) async {
    try {
      final result = await apiService.get(
        EndPoints.notificationsInbox,
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = result['data'] as Map<String, dynamic>;
      final items = (data['items'] as List)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final meta = data['meta'] as Map<String, dynamic>?;
      final hasNext = meta?['hasNext'] as bool? ?? false;
      return Right((items: items, hasNext: hasNext));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final result = await apiService.get(EndPoints.notificationsUnreadCount);
      final data = result['data'] as Map<String, dynamic>;
      return Right(Converter.toIntOrNull(data['unreadCount']) ?? 0);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, DateTime>> markAsRead(String id) async {
    try {
      final result = await apiService.patch(
        EndPoints.notificationMarkAsRead(id),
        data: const {},
      );
      final data = result['data'] as Map<String, dynamic>;
      final readAt = data['readAt'] != null
          ? DateTime.tryParse(data['readAt'] as String)
          : null;
      return Right(readAt ?? DateTime.now());
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    try {
      final result = await apiService.patch(
        EndPoints.notificationsMarkAllAsRead,
        data: const {},
      );
      final data = result['data'] as Map<String, dynamic>;
      return Right(Converter.toIntOrNull(data['updated']) ?? 0);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
