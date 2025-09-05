import 'dart:developer';

import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/notifications/data/data_source/data_source_impl.dart';

import '../../data/entities/notification.dart';

class NotificationViewModel extends ViewStateProvider {
  final notificationDataSource = NotificationDataSourceImpl();

  Notification? _notification;
  Notification? get notification => _notification;
  set notification(Notification? values) {
    _notification = values;
    notifyListeners();
  }

  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;
  set notifications(List<Notification> values) {
    if (values.isEmpty) {
      _notifications = [];
    } else {
      _notifications = [..._notifications, ...values];
    }
    notifyListeners();
  }

  bool get isUnreadNotificationPresent {
    for (Notification notification in notifications) {
      log('${notification.title} : ${notification.isRead}');
      if (!(notification.isRead ?? true)) {
        return true;
      }
    }

    return false;
  }

  int _page = 1;
  int get page => _page;
  void incrementPage() {
    _page += 1;
    notifyListeners();
  }

  bool _isLoadingNotifications = false;
  bool get isLoadingNotifications => _isLoadingNotifications;
  set isLoadingNotifications(bool value) {
    _isLoadingNotifications = value;
    notifyListeners();
  }

  bool _isMoreNotifications = false;
  bool get isMoreNotifications => _isMoreNotifications;
  set isMoreNotifications(bool value) {
    _isMoreNotifications = value;
    notifyListeners();
  }

  Future<Failure?> getNotifications({notify = false}) async {
    Failure? failure;

    notify ? setViewState(ViewState.busy) : isLoadingNotifications = true;

    if (notify) {
      _page = 1;
      isMoreNotifications = false;
      notifications = [];
    }

    final result = await notificationDataSource.getNotifications(page: page);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        notifications = res;

        if (res.isEmpty) {
          isMoreNotifications = false;
          return;
        }

        incrementPage();
      },
    );

    notify ? setViewState(ViewState.complete) : isLoadingNotifications = false;

    return failure;
  }

  Future<Failure?> markAsRead({required String notificationId}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await notificationDataSource.markNotificationAsRead(
      notificationId: notificationId,
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) async {
        _notifications = [];
        failure = await getNotifications(notify: true);
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> markAllAsRead() async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await notificationDataSource.markAllNotificationsAsRead();

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) async {
        _notifications = [];
        failure = await getNotifications(notify: true);
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }
}
