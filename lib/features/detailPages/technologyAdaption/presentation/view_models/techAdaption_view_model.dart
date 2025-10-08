import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/data/entities/techAdaption.dart';


class TechnologyAdoptionViewModel extends ViewStateProvider {
  final TechnologyAdoptionService _svc = TechnologyAdoptionService();

  TechnologyAdoptionModel? _techAdoption;
  TechnologyAdoptionModel? get techAdoption => _techAdoption;

  String? _message;
  String? get message => _message;

  Future<Failure?> getTechnologyAdoptionBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getTechnologyAdoptionBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _techAdoption = null;
      },
      (res) {
        _techAdoption = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}