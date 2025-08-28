import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/index.dart'
    show AuthDataSourceImpl;

class AuthViewModel extends ViewStateProvider {
  final AuthDataSourceImpl _authDataSource = AuthDataSourceImpl();

  bool _isLogin = true;
  bool get isLogin => _isLogin;
  set isLogin(bool val) {
    _isLogin = val;
    notifyListeners();
  }

  Future<Failure?> authenticate({
    required String email,
    required String password,
  }) async {
    Failure? failure;
    if (isLogin) {
      failure = await login(email: email, password: password);
    } else {
      failure = await register(email: email, password: password);
    }
    return failure;
  }

  Future<Failure?> login({
    required String email,
    required String password,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authDataSource.login(
      email: email,
      password: password,
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        getIt<AppStateProvider>().authModel = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> register({
    required String email,
    required String password,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authDataSource.register(
      email: email,
      password: password,
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        isLogin = true;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> googleLogin({required String tokenId}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authDataSource.googleLogin(tokenId: tokenId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
