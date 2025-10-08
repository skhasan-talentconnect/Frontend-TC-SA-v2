import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/data/entities/safety-security-model.dart';


class SafetyAndSecurityViewModel extends ViewStateProvider {
  final SafetyAndSecurityService _svc = SafetyAndSecurityService();

  SafetyAndSecurityModel? _safetyAndSecurity;
  SafetyAndSecurityModel? get safetyAndSecurity => _safetyAndSecurity;

  String? _message;
  String? get message => _message;

  Future<Failure?> getSafetyAndSecurityBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getSafetyAndSecurityBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _safetyAndSecurity = null;
      },
      (res) {
        _safetyAndSecurity = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}