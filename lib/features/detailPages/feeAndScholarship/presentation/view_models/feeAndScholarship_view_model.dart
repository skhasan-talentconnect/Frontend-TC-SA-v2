import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/entities/feeAndScholarship_model.dart';


class FeesAndScholarshipsViewModel extends ViewStateProvider {
  final FeesAndScholarshipsService _svc = FeesAndScholarshipsService();

  FeesAndScholarshipsModel? _feesAndScholarships;
  FeesAndScholarshipsModel? get feesAndScholarships => _feesAndScholarships;

  String? _message;
  String? get message => _message;

  Future<Failure?> getFeesAndScholarshipsBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getFeesAndScholarshipsBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _feesAndScholarships = null;
      },
      (res) {
        _feesAndScholarships = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}