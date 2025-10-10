import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/data/entities/admission-model.dart';
import 'data_source.dart';

class AdmissionTimelineService implements AbstractAdmissionTimelineService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<AdmissionTimelineModel?> getAdmissionTimelineBySchoolId({
    required String schoolId,
  }) async {
    // Make sure Endpoints.admissionTimeline is defined
    final endpoint = "${Endpoints.adminAdmissionTimeline}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = AdmissionTimelineModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}