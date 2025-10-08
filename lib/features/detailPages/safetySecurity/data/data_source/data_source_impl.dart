import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/data/entities/safety-security-model.dart';

import 'data_source.dart';

class SafetyAndSecurityService implements AbstractSafetyAndSecurityService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<SafetyAndSecurityModel?> getSafetyAndSecurityBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.safetyAndSecurity is defined in your constants
    final endpoint = "${Endpoints.adminSafetyAndSecurity}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = SafetyAndSecurityModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}