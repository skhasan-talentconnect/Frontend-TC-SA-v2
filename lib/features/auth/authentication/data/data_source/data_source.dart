import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/auth/authentication/index.dart' show AuthModel;

abstract class AuthDataSource {
  ResultFuture<AuthModel?> login({
    required String email,
    required String password,
  });

  ResultFuture<String?> register({
    required String email,
    required String password,
  });

  ResultFuture<AuthModel?> googleLogin({required String tokenId});
}
