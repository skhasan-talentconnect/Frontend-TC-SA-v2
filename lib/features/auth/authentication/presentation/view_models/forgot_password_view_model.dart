import 'package:tc_sa/core/common/index.dart' show ViewStateProvider, ViewState;
import 'package:tc_sa/core/network/index.dart' show Failure, APIFailure;
import 'package:tc_sa/features/auth/authentication/index.dart'
    show AuthDataSourceImpl;

class ForgotPasswordViewModel extends ViewStateProvider {
  final AuthDataSourceImpl _authDataSource = AuthDataSourceImpl();

  bool _isVerified = false;
  bool get isVerified => _isVerified;
  set isVerified(bool val) {
    _isVerified = val;
    notifyListeners();
  }

  Future<Failure?> forgetPasswordSendOtp({required String email}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authDataSource.forgetPassSendOtp(email: email);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        isVerified = true;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> forgetPassVerifyOtp({
    required String email,
    required String otp,
    required String password,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authDataSource.forgetPassVerifyOtp(
      email: email,
      otp: otp,
      password: password,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
