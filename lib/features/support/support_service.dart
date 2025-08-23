import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        Request,
        RequestMethod,
        ResultFuture,
        Endpoints,
        APIException;
import 'package:tc_sa/features/support/support_model.dart';

class SupportService {
  final NetworkService _networkService = NetworkService();

  ResultFuture<SupportModel?> addSupport({
    required String category,
    required String title,
    required String description,
    required String studId,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminSupport,
      body: {
        "category": category,
        "title": title,
        "description": description,
        "studId": studId,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final support = SupportModel.fromJson(response['data']);
        return Right(support);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<List<SupportModel>?> getSupportByStudId({
    required String studId,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSupport}/$studId",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final List<dynamic> data = response['data'];
        final List<SupportModel> supports =
            data.map((e) => SupportModel.fromJson(e)).toList();
        return Right(supports);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<SupportModel?> getSupportBySupportId({
    required String supportId,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSupportId}/$supportId",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final support = SupportModel.fromJson(response['data']);
        return Right(support);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<String?> deleteSupport({required String supportId}) async {
    Request r = Request(
      method: RequestMethod.delete,
      endpoint: "${Endpoints.adminSupport}/$supportId",
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
