import 'package:dartz/dartz.dart';
import 'package:tc_sa/common/models/index.dart' show UserPref, User;
import 'package:tc_sa/core/common/app_state_provider.dart';
import 'package:tc_sa/core/index.dart'
    show
        getIt,
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException,
        UserType,
        UserTypeExt;
import 'package:tc_sa/core/services/secret_repo.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final _networkService = getIt<NetworkService>();

  @override
  ResultFuture<User?> getUserDetails() async {
    Request r = Request(
      method: RequestMethod.get,
      isSafeRoute: true,
      endpoint: "${Endpoints.users}/${await SecretRepo.getString('auth_id')}",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final user = User.fromJson(response['data']);

        return Right(user);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<UserPref?> getUserPreferences() async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint:
          "${Endpoints.usersPreferences}/${getIt<AppStateProvider>().user?.sId}",
      isSafeRoute: true,
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final userPref = UserPref.fromJson(response['data']);

        return Right(userPref);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<User?> addProfile({
    required String name,
    required String email,
    required String phone,
    required String state,
    required String city,
    required String gender,
    required String dateOfBirth,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      isSafeRoute: true,
      endpoint: Endpoints.users,
      body: {
        'authId': await SecretRepo.getString('auth_id'),
        'name': name,
        'email': email,
        'contactNo': phone,
        'state': state,
        'city': city,
        'gender': gender.toLowerCase(),
        'dateOfBirth': dateOfBirth,
        'userType': UserType.student.label,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final user = User.fromJson(response['data']);

        return Right(user);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
