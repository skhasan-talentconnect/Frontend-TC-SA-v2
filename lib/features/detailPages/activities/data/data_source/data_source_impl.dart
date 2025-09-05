import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/detailPages/activities/data/entities/activities_model.dart';


class ActivitiesService {
  final NetworkService _networkService = NetworkService();

  ResultFuture<ActivitiesModel?> addActivities({
    required String schoolId,
    required List<String> activities,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminSchoolsActivities,
      body: {"schoolId": schoolId, "activities": activities},
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final activities = ActivitiesModel.fromJson(response['data']);

        return Right(activities);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<ActivitiesModel?> updateActivities({
    required String schoolId,
    required List<String> activities,
  }) async {
    Request r = Request(
      method: RequestMethod.put,
      endpoint: "${Endpoints.adminSchoolsActivities}/$schoolId",
      body: {"activities": activities},
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final updatedActivities = ActivitiesModel.fromJson(response['data']);

        return Right(updatedActivities);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<ActivitiesModel?> getActivitiesBySchoolId({
    required String schoolId,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSchoolsActivities}/$schoolId",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final getActivities = ActivitiesModel.fromJson(response['data']);
        return Right(getActivities);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
