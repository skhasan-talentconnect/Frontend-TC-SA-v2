import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/detailPages/amenity/data/entities/amenity_model.dart';


class AmenitiesService {
  final NetworkService _networkService = NetworkService();

  ResultFuture<AmenitiesModel?> addAmenities({
    required String schoolId,
    required List<String> predefinedAmenities,
    List<String>? customAmenities,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminSchoolsAmenities,
      body: {
        "schoolId": schoolId,
        "predefinedAmenities": predefinedAmenities,
        "customAmenities": customAmenities,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final amenities = AmenitiesModel.fromJson(response['data']);

        return Right(amenities);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<AmenitiesModel?> updateAmenities({
    required String schoolId,
    required List<String> predefinedAmenities,
    List<String>? customAmenities,
  }) async {
    Request r = Request(
      method: RequestMethod.put,
      endpoint: "${Endpoints.adminSchoolsAmenities}/$schoolId",
      body: {
        "predefinedAmenities": predefinedAmenities,
        "customAmenities": customAmenities,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final updatedAmenities = AmenitiesModel.fromJson(response['data']);

        return Right(updatedAmenities);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<AmenitiesModel?> getAmenitiesBySchoolId({
    required String schoolId,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSchoolsAmenities}/$schoolId",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final getAmenities = AmenitiesModel.fromJson(response['data']);
        return Right(getAmenities);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
