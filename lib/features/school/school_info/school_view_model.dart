import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/school/school_info/school_service.dart';

class SchoolViewModel extends ViewStateProvider {
  final SchoolService _schoolService = SchoolService();

  Future<Failure?> addSchools({
    required String name,
    required String description,
    required String board,
    required String state,
    required String city,
    required String schoolMode,
    required String genderType,
    required List<String> shifts,
    required String feeRange,
    required String upto,
    required String email,
    required String mobileNo,
    required List<String> languageMedium,
    required String transportAvailable,
    required String status,
    List<String>? specialist,
    List<String>? tags,
    String? website,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _schoolService.addSchool(
      name: name,
      description: description,
      board: board,
      state: state,
      city: city,
      schoolMode: schoolMode,
      genderType: genderType,
      shifts: shifts,
      feeRange: feeRange,
      upto: upto,
      email: email,
      mobileNo: mobileNo,
      languageMedium: languageMedium,
      transportAvailable: transportAvailable,
      specialist: specialist,
      tags: tags,
      website: website,
      status: status,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> updateSchools({
    required String id,
    required String name,
    required String description,
    required String board,
    required String state,
    required String city,
    required String schoolMode,
    required String genderType,
    required List<String> shifts,
    required String feeRange,
    required String upto,
    required String email,
    required String mobileNo,
    required List<String> languageMedium,
    required String transportAvailable,
    required String status,
    List<String>? specialist,
    List<String>? tags,
    String? website,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _schoolService.updateSchool(
      id: id,
      name: name,
      description: description,
      board: board,
      state: state,
      city: city,
      schoolMode: schoolMode,
      genderType: genderType,
      shifts: shifts,
      feeRange: feeRange,
      upto: upto,
      email: email,
      mobileNo: mobileNo,
      languageMedium: languageMedium,
      transportAvailable: transportAvailable,
      specialist: specialist,
      tags: tags,
      website: website,
      status: status,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> deleteSchools({required String id}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _schoolService.deleteSchool(id: id);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getSchoolsById({required String id}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _schoolService.getSchoolById(id: id);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getSchoolsByStatus({required String status}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _schoolService.getSchoolsByStatus(status: status);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
