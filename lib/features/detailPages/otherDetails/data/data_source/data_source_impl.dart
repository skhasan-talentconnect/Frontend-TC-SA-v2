import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';

import 'data_source.dart';

class OtherDetailsService implements AbstractOtherDetailsService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<OtherDetailsModel?> getOtherDetailsBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.otherDetails is defined in your constants
    final endpoint = "${Endpoints.adminOtherDetails}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = OtherDetailsModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}