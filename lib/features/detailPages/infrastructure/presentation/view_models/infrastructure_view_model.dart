import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/infrastructure/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/infrastructure/data/entities/infrastructure_model.dart';


class InfrastructureViewModel extends ViewStateProvider {
  final InfrastructureService _svc = InfrastructureService();

  InfrastructureModel? _infrastructure;
  InfrastructureModel? get infrastructure => _infrastructure;

  String? _message;
  String? get message => _message;

  Future<Failure?> getInfrastructureBySchoolId({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getInfrastructureBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _infrastructure = null;
      },
      (res) {
        _infrastructure = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}