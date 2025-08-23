import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart' show SharedPrefHelper;
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/users/preference/pref_model.dart';

class PrefService {
  final NetworkService _networkService = NetworkService();

  final String? deviceToken = SharedPrefHelper.getString('deviceToken');
  ResultFuture<PreferenceModel?> addPreferences({
    required String studentId,
    required String state,
    required String city,
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.usersPreferences,
      body: {
        "studentId": studentId,
        "state": state,
        "city": city,
        "boards": boards,
        "preferredStandard": preferredStandard,
        "interests": interests,
        "schoolType": schoolType,
        "shift": shift,
      },
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final prefModel = PreferenceModel.fromJson(response['data']);

        return Right(prefModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<PreferenceModel?> updatePreferences({
    required String studentId,
    required String state,
    required String city,
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  }) async {
    Request r = Request(
      method: RequestMethod.put,
      endpoint: "${Endpoints.usersPreferences}/$studentId",
      body: {
        "studentId": studentId,
        "state": state,
        "city": city,
        "boards": boards,
        "preferredStandard": preferredStandard,
        "interests": interests,
        "schoolType": schoolType,
        "shift": shift,
      },
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final prefModel = PreferenceModel.fromJson(response['data']);

        return Right(prefModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<PreferenceModel?> getPreferences({
    required String studentId,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.usersPreferences}/$studentId",
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final prefModel = PreferenceModel.fromJson(response['data']);

        return Right(prefModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
