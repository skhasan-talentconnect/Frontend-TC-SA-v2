import 'package:tc_sa/core/common/view_state_controller.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/school/amenities/amenities_service.dart';

class AmenitiesViewModel extends ViewStateProvider {
  final AmenitiesService _amenitiesService = AmenitiesService();

  Future<Failure?> addAmenities({
    required String schoolId,
    required List<String> predefinedAmenities,
    List<String>? customAmenities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _amenitiesService.addAmenities(
      schoolId: schoolId,
      predefinedAmenities: predefinedAmenities,
      customAmenities: customAmenities,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> updateAmenities({
    required String schoolId,
    required List<String> predefinedAmenities,
    List<String>? customAmenities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _amenitiesService.updateAmenities(
      schoolId: schoolId,
      predefinedAmenities: predefinedAmenities,
      customAmenities: customAmenities,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getAmenitiesBySchoolId({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _amenitiesService.getAmenitiesBySchoolId(
      schoolId: schoolId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
