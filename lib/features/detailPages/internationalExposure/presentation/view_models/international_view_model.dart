import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/data/entities/international-model.dart';


class InternationalExposureViewModel extends ViewStateProvider {
  final InternationalExposureService _svc = InternationalExposureService();

  InternationalExposureModel? _exposure;
  InternationalExposureModel? get exposure => _exposure;

  String? _message;
  String? get message => _message;

  Future<Failure?> getInternationalExposureBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getInternationalExposureBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _exposure = null;
      },
      (res) {
        _exposure = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}