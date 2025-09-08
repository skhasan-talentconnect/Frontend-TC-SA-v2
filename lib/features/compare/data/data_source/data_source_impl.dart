import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/compare/data/data_source/data_source.dart';
import 'package:tc_sa/features/compare/data/entities/school_compare_model.dart';

class CompareDataSourceImpl implements CompareDataSource {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<Map<String, SchoolCompareModel>?> compareSchools({
    required String schoolId1,
    required String schoolId2,
  }) async {
    final request = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminCompare,
      body: {'schoolId1': schoolId1, 'schoolId2': schoolId2},
    );

    try {
      final result = await _networkService.request(request);
      final data = result.data['data'] as Map<String, dynamic>;
      if (data.isNotEmpty) {
        return Right({
          'school1': SchoolCompareModel.fromJson(
            data['school1'] as Map<String, dynamic>,
          ),
          'school2': SchoolCompareModel.fromJson(
            data['school2'] as Map<String, dynamic>,
          ),
        });
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
