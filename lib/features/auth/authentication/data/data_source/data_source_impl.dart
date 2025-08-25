import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart'
    show SharedPrefHelper, AuthProvider, UserType;
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/auth/authentication/index.dart'
    show AuthModel, AuthDataSource;

class AuthDataSourceImpl implements AuthDataSource {
  final _networkService = NetworkService();

  final String? deviceToken = SharedPrefHelper.getString('deviceToken');

  @override
  ResultFuture<AuthModel?> login({
    required String email,
    required String password,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authLogin,
      body: {"email": email, "password": password, "deviceToken": deviceToken},
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final authModel = AuthModel.fromJson(response['data']);

        return Right(authModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<String?> register({
    required String email,
    required String password,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authRegister,
      body: {
        "email": email,
        "password": password,
        "deviceToken": deviceToken,
        "authProvider": AuthProvider.email,
        "userType": UserType.student,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final msg = response['message'] as String;

        return Right(msg);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<AuthModel?> googleLogin({required String tokenId}) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authGoogle,
      body: {
        "deviceToken": deviceToken,
        "authProvider": AuthProvider.google,
        "userType": UserType.student,
        "tokenId": tokenId,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final authModel = AuthModel.fromJson(
          response['data'] as Map<String, dynamic>,
        );

        return Right(authModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
