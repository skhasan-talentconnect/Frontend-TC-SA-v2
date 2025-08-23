import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/school/school_info/school_model.dart';

class FilterService {
  final NetworkService _networkService = NetworkService();

  ResultFuture<List<SchoolModel>?> getSchoolsByFeeRange({
    required String feeRange,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.adminFilterFeeRange}?feeRange=$feeRange',
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final List<dynamic> schoolsData = response['data'];
        final List<SchoolModel> schools =
            schoolsData.map((json) => SchoolModel.fromJson(json)).toList();

        return Right(schools);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  ResultFuture<List<SchoolModel>?> getSchoolsByShift({
    required String shifts,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.adminFilterShift}?shifts=$shifts',
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final List<dynamic> schoolsData = response['data'];
        final List<SchoolModel> schools =
            schoolsData.map((json) => SchoolModel.fromJson(json)).toList();

        return Right(schools);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }
}
