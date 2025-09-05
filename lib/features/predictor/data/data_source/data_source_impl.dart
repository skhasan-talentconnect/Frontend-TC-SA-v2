import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/endpoints.dart';
import 'package:tc_sa/core/network/exceptions.dart';
import 'package:tc_sa/core/network/network.dart';
import 'package:tc_sa/core/network/request.dart';
import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';


class PredictorDataSourceImpl {
  final NetworkService _networkService = NetworkService();

  ResultFuture<List<SchoolModel>?> predictSchools(
    Map<String, dynamic> filters,
  ) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminPredictSchools,
      body: filters,
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
