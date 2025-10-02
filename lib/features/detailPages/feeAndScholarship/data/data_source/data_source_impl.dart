

import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/endpoints.dart';
import 'package:tc_sa/core/network/exceptions.dart';
import 'package:tc_sa/core/network/network.dart';
import 'package:tc_sa/core/network/request.dart';
import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/data_source/data_source.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/entities/feeAndScholarship_model.dart';

class FeesAndScholarshipsService implements AbstractFeesAndScholarshipsService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<FeesAndScholarshipsModel?> getFeesAndScholarshipsBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.feeAndScholarship is defined in your constants
    final endpoint = "${Endpoints.adminfeeAndScholarship}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = FeesAndScholarshipsModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}