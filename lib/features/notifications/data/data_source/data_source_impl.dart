import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';

import '../entities/notification.dart';
import 'data_source.dart';

class NotificationDataSourceImpl implements NotificationDataSource {
  final _networkService = NetworkService();
  @override
  ResultFuture<List<Notification>> getNotifications({required int page}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint:
          '${Endpoints.notifications}/${getIt<AppStateProvider>().authModel?.sId}',
      queryParams: {'page': page.toString(), 'limit': '10'},
      isSafeRoute: true,
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final list =
            (response['data']['notifications'] as List<dynamic>)
                .map((e) => Notification.fromJson(e))
                .toList();
        return Right(list);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right([]);
  }

  @override
  ResultFuture<Notification?> markNotificationAsRead({
    required String notificationId,
  }) async {
    Request r = Request(
      method: RequestMethod.patch,
      endpoint: '${Endpoints.notifications}/$notificationId/read',
      isSafeRoute: true,
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final notification = Notification.fromJson(
          response['data'] as Map<String, dynamic>,
        );
        return Right(notification);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultVoid markAllNotificationsAsRead() async {
    Request r = Request(
      method: RequestMethod.patch,
      isSafeRoute: true,
      endpoint:
          '${Endpoints.notifications}/${getIt<AppStateProvider>().authModel?.sId}/read-all',
    );

    try {
      await _networkService.request(r);
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
