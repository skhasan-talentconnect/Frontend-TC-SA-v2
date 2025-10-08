import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/data/entities/international-model.dart';

import 'data_source.dart';

class InternationalExposureService implements AbstractInternationalExposureService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<InternationalExposureModel?> getInternationalExposureBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.internationalExposure is defined in your constants
    final endpoint = "${Endpoints.adminInternationalExposure}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = InternationalExposureModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}