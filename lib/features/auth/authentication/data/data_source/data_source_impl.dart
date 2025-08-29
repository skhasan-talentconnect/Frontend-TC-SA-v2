import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tc_sa/core/extensions/dio_exception_ext.dart';
import 'package:tc_sa/core/index.dart'
    show SharedPrefHelper, AuthProvider, UserType, UserTypeExt, AuthProviderExt;
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/auth/authentication/index.dart'
    show AuthModel, AuthDataSource;

class AuthDataSourceImpl  implements AuthDataSource {
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
      print((e is DioException) ? e.getStatusCodeFromResponse() : 500);
      return Left(
        APIException(
          message:
              (e is DioException) ? e.getErrorFromResponse() : e.toString(),
          statusCode: (e is DioException) ? e.getStatusCodeFromResponse() : 500,
        ),
      );
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
        "authProvider": AuthProvider.email.label,
        "userType": UserType.student.label,
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

  @override
  ResultVoid resetPassword({
    required String oldPass,
    required String newPass,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authResetPassword,
      body: {"oldPassword": oldPass, "newPassword": newPass},
    );

    try {
      await _networkService.request(r);
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultVoid forgetPassSendOtp({required String email}) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authForgotPasswordSendOtp,
      body: {"email": email},
    );

    try {
      await _networkService.request(r);
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultVoid forgetPassVerifyOtp({
    required String email,
    required String otp,
    required String password,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authForgotPasswordVerifyOtp,
      body: {"email": email, "otp": otp, "newPassword": password},
    );

    try {
      await _networkService.request(r);
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
