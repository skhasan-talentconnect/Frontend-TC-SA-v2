import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/faculty/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/faculty/data/entities/faculty-model.dart';


class FacultyViewModel extends ViewStateProvider {
  final FacultyService _svc = FacultyService();

  FacultyModel? _faculty;
  FacultyModel? get faculty => _faculty;

  String? _message;
  String? get message => _message;

  Future<Failure?> getFacultyBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getFacultyBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _faculty = null;
      },
      (res) {
        _faculty = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}