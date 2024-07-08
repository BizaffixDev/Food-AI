import '../data_sources/notification_data_source.dart';
import '../models/notification_response_model.dart';

abstract class NotificationRepository {

  Future<NotificationData> getNotifications(
      {required int userId, });

}

class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRepositoryImpl(this.notificationDataSource);

  final NotificationDataSource notificationDataSource;

  @override
  Future<NotificationData> getNotifications({required int userId}) {
    return notificationDataSource.getNotifications(userId: userId);
  }




}
