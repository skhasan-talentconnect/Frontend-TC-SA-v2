import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/overview/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';

class OverviewViewModel extends ViewStateProvider {
  final OverviewDataSourceImpl _service = OverviewDataSourceImpl();

  // STATE
  SchoolModel? _school;
  SchoolModel? get school => _school;

  List<SchoolModel> _schoolsByStatus = [];
  List<SchoolModel> get schoolsByStatus => _schoolsByStatus;

  String? _message;
  String? get message => _message;

  // ---- ACTIONS ----

  Future<Failure?> getSchoolsById({required String id}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _service.getSchoolById(id: id);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _school = null;
    }, (res) {
      _school = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> getSchoolsByStatus({required String status}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _service.getSchoolsByStatus(status: status);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _schoolsByStatus = [];
    }, (res) {
      _schoolsByStatus = res ?? [];
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

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

    final result = await _service.addSchool(
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
      _message = failure?.message;
    }, (res) {
      _school = res; // optional: return created school
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
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

    final result = await _service.updateSchool(
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
      _message = failure?.message;
    }, (res) {
      _school = res; // keep local state in sync
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> deleteSchools({required String id}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _service.deleteSchool(id: id);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _message = res; // optional: “deleted successfully”
      if (_school?.id == id) _school = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
