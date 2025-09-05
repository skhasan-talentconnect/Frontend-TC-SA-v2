import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/activities/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/activities/data/entities/activities_model.dart';

class ActivitiesViewModel extends ViewStateProvider {
  final ActivitiesService _svc = ActivitiesService();

  ActivitiesModel? _activities;
  ActivitiesModel? get activitiesModel => _activities;

  String? _message;
  String? get message => _message;

  Future<Failure?> getActivitiesBySchoolId({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getActivitiesBySchoolId(schoolId: schoolId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _activities = null;
    }, (res) {
      _activities = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> addActivities({
    required String schoolId,
    required List<String> activities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.addActivities(schoolId: schoolId, activities: activities);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _activities = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> updateActivities({
    required String schoolId,
    required List<String> activities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.updateActivities(schoolId: schoolId, activities: activities);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _activities = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
