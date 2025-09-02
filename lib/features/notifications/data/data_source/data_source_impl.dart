import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/core/network/typedef.dart';

import '../entities/notification.dart';
import 'data_source.dart';

class NotificationDataSourceImpl implements NotificationDataSource {
  final _networkService = NetworkService();
  @override
  ResultFuture<List<Notification>> getNotifications({
    required String authId,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.notifications}/$authId',
      isSafeRoute: true,
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final list =
            (response['data'] as List<dynamic>)
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
  ResultVoid markAllNotificationsAsRead({required String authId}) async {
    Request r = Request(
      method: RequestMethod.patch,
      endpoint: '${Endpoints.notifications}/$authId/read-all',
    );

    try {
      await _networkService.request(r);
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
