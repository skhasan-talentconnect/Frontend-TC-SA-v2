import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/amenity/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/amenity/data/entities/amenity_model.dart';

class AmenitiesViewModel extends ViewStateProvider {
  final AmenitiesService _svc = AmenitiesService();

  AmenitiesModel? _amenities;
  AmenitiesModel? get amenities => _amenities;

  String? _message;
  String? get message => _message;

  Future<Failure?> getAmenitiesBySchoolId({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getAmenitiesBySchoolId(schoolId: schoolId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _amenities = null;
    }, (res) {
      _amenities = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> addAmenities({
    required String schoolId,
    required List<String> predefinedAmenities,
    List<String>? customAmenities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.addAmenities(
      schoolId: schoolId,
      predefinedAmenities: predefinedAmenities,
      customAmenities: customAmenities,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _amenities = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> updateAmenities({
    required String schoolId,
    required List<String> predefinedAmenities,
    List<String>? customAmenities,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.updateAmenities(
      schoolId: schoolId,
      predefinedAmenities: predefinedAmenities,
      customAmenities: customAmenities,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _amenities = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
