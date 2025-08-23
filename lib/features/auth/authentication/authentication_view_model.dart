import 'package:tc_sa/core/common/view_state_controller.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/auth/authentication/authentication_service.dart';

class AuthenticationViewModel extends ViewStateProvider {
  final AuthenticationService _authenticationService = AuthenticationService();

  Future<Failure?> login({
    required String email,
    required String password,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _authenticationService.login(
      email: email,
      password: password,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
