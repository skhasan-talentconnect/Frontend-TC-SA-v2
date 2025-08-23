import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tc_sa/core/extensions/index.dart';
import 'package:tc_sa/core/network/index.dart';

class AppService {
  ResultFuture<List<dynamic>?> getReviews({required String id}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.reviewsAdmin}/$id",
    );

    try {
      final response = await NetworkService().request(r);
      final result = response.data as Map<String, dynamic>;

      if (result.isNotEmpty) {
        final data = response.data as Map<String, dynamic>;

        return Right(data['data'] as List<dynamic>);
      }
    } catch (e) {
      return Left(
        APIException(
          message:
              (e is DioException) ? e.getErrorFromResponse() : e.toString(),
          statusCode: (e is DioException) ? e.getStatusCodeFromResponse() : 500,
        ),
      );
    }

    return Right(null);
  }
}
