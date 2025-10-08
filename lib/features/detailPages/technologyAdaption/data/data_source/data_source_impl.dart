import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/data/entities/techAdaption.dart';

import 'data_source.dart';

class TechnologyAdoptionService implements AbstractTechnologyAdoptionService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<TechnologyAdoptionModel?> getTechnologyAdoptionBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.technologyAdoption is defined in your constants
    final endpoint = "${Endpoints.adminTechAdoption}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = TechnologyAdoptionModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}