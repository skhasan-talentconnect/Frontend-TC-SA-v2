import 'package:tc_sa/core/network/index.dart' show ResultFuture, ResultVoid;
import 'package:tc_sa/features/auth/authentication/index.dart' show AuthModel;

abstract class AuthDataSource {
  ResultFuture<AuthModel?> getAuth();

  ResultFuture<AuthModel?> login({
    required String email,
    required String password,
  });

  ResultVoid register({required String email, required String password});

  ResultFuture<AuthModel?> googleLogin({required String tokenId});

  ResultVoid resetPassword({required String oldPass, required String newPass});

  ResultVoid forgetPassSendOtp({required String email});

  ResultVoid forgetPassVerifyOtp({
    required String email,
    required String otp,
    required String password,
  });
}
