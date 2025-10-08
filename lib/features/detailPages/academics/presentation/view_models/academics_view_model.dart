import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/academics/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/academics/data/entities/academics_model.dart';

class AcademicsViewModel extends ViewStateProvider {
  final AcademicsService _svc = AcademicsService();

  AcademicsModel? _academics;
  AcademicsModel? get academics => _academics;

  String? _message;
  String? get message => _message;

  Future<Failure?> getAcademicsBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getAcademicsBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _academics = null;
      },
      (res) {
        _academics = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}