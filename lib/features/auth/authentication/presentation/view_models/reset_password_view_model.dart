import 'package:tc_sa/core/common/index.dart' show ViewStateProvider, ViewState;
import 'package:tc_sa/core/network/index.dart' show Failure, APIFailure;
import 'package:tc_sa/features/auth/authentication/index.dart'
    show AuthDataSourceImpl;

class ResetPasswordViewModel extends ViewStateProvider {
  final AuthDataSourceImpl _authDataSource = AuthDataSourceImpl();

  Future<Failure?> resetPassword({
    required String oldPass,
    required String newPass,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authDataSource.resetPassword(
      oldPass: oldPass,
      newPass: newPass,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
