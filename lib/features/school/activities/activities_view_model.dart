import 'package:tc_sa/core/common/view_state_controller.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/school/activities/activities_service.dart';

class ActivitiesViewModel extends ViewStateProvider {
  final ActivitiesService _activitiesService = ActivitiesService();

  Future<Failure?> addActivities({
    required String schoolId,
    required List<String> activities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _activitiesService.addActivities(
      schoolId: schoolId,
      activities: activities,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> updateActivities({
    required String schoolId,
    required List<String> activities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _activitiesService.updateActivities(
      schoolId: schoolId,
      activities: activities,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getActivitiesBySchoolId({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _activitiesService.getActivitiesBySchoolId(
      schoolId: schoolId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
