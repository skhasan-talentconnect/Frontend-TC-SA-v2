import 'package:dartz/dartz.dart';
import 'package:tc_sa/common/models/school_card_model.dart';
import 'package:tc_sa/core/index.dart';

import 'data_source.dart';

class SchoolDataSourceImpl implements SchoolDataSource {
  final _networkService = getIt<NetworkService>();

  @override
  ResultFuture<List<SchoolCardModel>> getSchools({
    Map<String, dynamic>? filters,
  }) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSchoolsStatus}/accepted",
      queryParams: filters ?? {},
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data['data'] as List<dynamic>;

      if (response.isNotEmpty) {
        final schools =
            response.map((e) => SchoolCardModel.fromJson(e)).toList();
        return Right(schools);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right([]);
  }
}
