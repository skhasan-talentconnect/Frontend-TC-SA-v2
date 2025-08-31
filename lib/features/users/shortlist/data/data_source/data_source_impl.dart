import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart' show SharedPrefHelper;
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;

class ShortlistDataSourceImpl {
  final NetworkService _networkService = NetworkService();

  final String? deviceToken = SharedPrefHelper.getString('deviceToken');

  ResultFuture<String?> addShortlist({
    required String authId,
    required String schoolId,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.usersShortlist,
      body: {"authId": authId, "schoolId": schoolId},
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final msg = response['message'];

        return Right(msg);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<List<dynamic>?> getShortlist({required String authId}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.usersShortlist}/$authId",
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        // final shortlistModel = ShortlistModel.fromJson(response['data']);

        return Right([]);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<int?> getShortlistCount({required String authId}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.usersShortlist}/count/$authId",
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final count = response['data'];

        return Right(count);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<String?> removeShortlist({
    required String authId,
    required String schoolId,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: "${Endpoints.usersShortlist}/remove",
      body: {"authId": authId, "schoolId": schoolId},
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final msg = response['message'];

        return Right(msg);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
