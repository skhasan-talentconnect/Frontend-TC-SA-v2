import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/faculty/data/entities/faculty-model.dart';
import 'data_source.dart';

class FacultyService implements AbstractFacultyService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<FacultyModel?> getFacultyBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.faculty is defined in your constants
    final endpoint = "${Endpoints.adminFaculty}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = FacultyModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}