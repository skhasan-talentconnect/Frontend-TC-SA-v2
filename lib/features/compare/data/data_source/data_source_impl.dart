// features/compare/data/data_source/data_source_impl.dart
import 'package:tc_sa/core/index.dart';
import 'package:dartz/dartz.dart';
import 'package:tc_sa/features/compare/data/data_source/data_source.dart';

class CompareDataSourceImpl implements CompareDataSource {

  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<Map<String, dynamic>> compareSchools({
    required String schoolId1,
    required String schoolId2,
  }) async {
    final request = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminCompare, // "/api/admin/compare"
      body: {
        'schoolId1': schoolId1,
        'schoolId2': schoolId2,
      },
    );

    try {
      final result = await _networkService.request(request);
      final data = result.data['data'] as Map<String, dynamic>?;
      return Right(data ?? <String, dynamic>{});
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
