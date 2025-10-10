import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/data/entities/admission-model.dart';


class AdmissionTimelineViewModel extends ViewStateProvider {
  final AdmissionTimelineService _svc = AdmissionTimelineService();

  AdmissionTimelineModel? _admissionTimeline;
  AdmissionTimelineModel? get admissionTimeline => _admissionTimeline;

  String? _message;
  String? get message => _message;

  Future<Failure?> getAdmissionTimelineBySchoolId({
    required String schoolId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getAdmissionTimelineBySchoolId(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _admissionTimeline = null;
      },
      (res) {
        _admissionTimeline = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}