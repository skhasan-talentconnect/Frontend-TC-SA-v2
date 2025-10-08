import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import '../entities/academics_model.dart';
import 'data_source.dart';

class AcademicsService implements AbstractAcademicsService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<AcademicsModel?> getAcademicsBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.academics is defined in your constants
    final endpoint = "${Endpoints.adminAcademics}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = AcademicsModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}