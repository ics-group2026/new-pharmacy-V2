import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/notification_model.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, ({List<NotificationModel> items, bool hasNext})>>
  getInboxNotifications({int page = 1, int limit = 10});

  Future<Either<Failure, int>> getUnreadCount();

  Future<Either<Failure, DateTime>> markAsRead(String id);

  Future<Either<Failure, int>> markAllAsRead();
}
