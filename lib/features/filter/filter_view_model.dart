import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/filter/filter_service.dart';

class FilterViewModel extends ViewStateProvider {
  final FilterService _filterService = FilterService();

  Future<Failure?> getSchoolsByFeeRange({required String feeRange}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _filterService.getSchoolsByFeeRange(
      feeRange: feeRange,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getSchoolsByShift({required String shifts}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _filterService.getSchoolsByShift(shifts: shifts);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
