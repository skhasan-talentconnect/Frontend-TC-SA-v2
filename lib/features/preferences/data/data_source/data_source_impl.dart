import 'package:dartz/dartz.dart';
import 'package:tc_sa/common/index.dart' show UserPref;
import 'package:tc_sa/core/index.dart'
    show
        Request,
        NetworkService,
        AppStateProvider,
        RequestMethod,
        ResultFuture,
        Endpoints,
        getIt,
        APIException;
import 'package:tc_sa/features/preferences/index.dart' show PrefDataSource;

class PrefDataSourceImpl implements PrefDataSource {
  final NetworkService _networkService = getIt<NetworkService>();
  final AppStateProvider _appStateProvider = getIt<AppStateProvider>();

  @override
  ResultFuture<UserPref?> addPreferences({
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
        "studentId": _appStateProvider.user?.sId,
        "state": _appStateProvider.user?.state,
        "city": _appStateProvider.user?.city,
        "boards": boards,
        "preferredStandard":
            preferredStandard == 'PlaySchool'
                ? 'playSchool'
                : preferredStandard.toLowerCase(),
        "interests": interests,
        "schoolType": schoolType.toLowerCase(),
        "shift": shift.toLowerCase(),
      },
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final prefModel = UserPref.fromJson(response['data']);

        return Right(prefModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<UserPref?> updatePreferences({
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  }) async {
    Request r = Request(
      method: RequestMethod.put,
      endpoint: "${Endpoints.usersPreferences}/${_appStateProvider.user?.sId}",
      body: {
        "studentId": _appStateProvider.user?.sId,
        "state": _appStateProvider.user?.state,
        "city": _appStateProvider.user?.city,
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
        final prefModel = UserPref.fromJson(response['data']);

        return Right(prefModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<UserPref?> getPreferences() async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.usersPreferences}/${_appStateProvider.user?.sId}",
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final prefModel = UserPref.fromJson(response['data']);

        return Right(prefModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
