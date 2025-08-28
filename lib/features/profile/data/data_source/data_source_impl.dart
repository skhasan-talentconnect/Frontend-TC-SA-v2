import 'package:dartz/dartz.dart';
import 'package:tc_sa/common/models/index.dart' show UserPref, User;
import 'package:tc_sa/core/index.dart'
    show
        getIt,
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/profile/data/data_source/data_source.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final _networkService = getIt<NetworkService>();

  @override
  ResultFuture<User?> getUserDetails({required String authId}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: Endpoints.authLogin,
      queryParams: {'authId': authId},
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
  ResultFuture<UserPref?> getUserPreferences({required String studId}) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authLogin,
      queryParams: {'studId': studId},
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
}
