import 'package:tc_sa/core/network/index.dart' show ResultFuture, ResultVoid;
import 'package:tc_sa/features/notifications/data/index.dart' show Notification;

abstract class NotificationDataSource {
  /// Get all notifications for a user
  ResultFuture<List<Notification>> getNotifications({required int page});

  /// Mark single notification as read
  ResultFuture<Notification?> markNotificationAsRead({
    required String notificationId,
  });

  /// Mark all notifications as read for a user
  ResultVoid markAllNotificationsAsRead();
}
