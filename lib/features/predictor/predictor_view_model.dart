import 'package:tc_sa/core/common/view_state_controller.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/predictor/predictor_service.dart';

class PrefViewModel extends ViewStateProvider {
  final PredictorService _predictorService = PredictorService();

  Future<Failure?> predictSchools({
    required Map<String, dynamic> filters,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _predictorService.predictSchools(filters);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
