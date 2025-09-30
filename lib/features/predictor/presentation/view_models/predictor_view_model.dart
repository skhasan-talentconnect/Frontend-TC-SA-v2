import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/predictor/data/data_source/data_source_impl.dart';

import '../../../../common/models/school_card_model.dart';

class PrefViewModel extends ViewStateProvider {
  final PredictorDataSourceImpl _predictorService = PredictorDataSourceImpl();
  List<SchoolCardModel> _predictedSchools = [];

  List<SchoolCardModel> get predictedSchools => _predictedSchools;

  Future<Failure?> predictSchools({
    required Map<String, dynamic> filters,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _predictorService.predictSchools(filters);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (schools) {
        _predictedSchools = schools ?? [];
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }
}
