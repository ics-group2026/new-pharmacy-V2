import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/notifications_repo.dart';

class UnreadNotificationsCubit extends Cubit<int> {
  final NotificationsRepo notificationsRepo;

  UnreadNotificationsCubit(this.notificationsRepo) : super(0);

  Future<void> getUnreadCount() async {
    final result = await notificationsRepo.getUnreadCount();
    result.fold((_) {}, (count) => emit(count));
  }
}
