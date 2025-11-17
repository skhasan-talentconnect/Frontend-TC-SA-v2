// lib/features/application/applications/presentation/view_models/application_view_model.dart
import 'package:tc_sa/core/index.dart' show ViewState, ViewStateProvider, Failure, getIt, APIFailure;
import 'package:tc_sa/features/application/applications/data/data_source/application_data_source.dart';
import 'package:tc_sa/features/application/applications/data/data_source/application_data_source_impl.dart';
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';

class ApplicationViewModel extends ViewStateProvider {
  final ApplicationDataSource _ds = getIt<ApplicationDataSourceImpl>();

  StudentApplication? _application;
  StudentApplication? get application => _application;
  void setApplication(StudentApplication? val) {
    _application = val;
    notifyListeners();
  }

  List<StudentApplication> _applications = const [];
  List<StudentApplication> get applications => _applications;

  String? message;

  // ADD
  Future<Failure?> addApplication(StudentApplication payload) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.addApplication(payload: payload);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        _application = res;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // GET ALL
  Future<Failure?> getAllApplications() async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.getAllApplications();
    result.fold(
      (exception) => failure = APIFailure.fromException(exception: exception),
      (res) => _applications = res,
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // GET by studId -> returns list of applications
  Future<Failure?> getApplicationsByStudId({required String studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.getStudApplicationsByStudId(studId: studId);
    result.fold(
      (exception) => failure = APIFailure.fromException(exception: exception),
      (res) {
        _applications = res;
      },
    );

    if (_applications.isEmpty) {
      message = 'No applications found';
    }

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // GET single by applicationId
  Future<Failure?> getApplicationById({required String applicationId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.getApplicationById(applicationId: applicationId);
    result.fold(
      (exception) => failure = APIFailure.fromException(exception: exception),
      (res) {
        _application = res;
      },
    );

    if (_application == null) {
      message = 'No application found';
    }

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // UPDATE by applicationId
  Future<Failure?> updateApplication({
    required String applicationId,
    required StudentApplication payload,
  }) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.updateApplication(applicationId: applicationId, payload: payload);
    result.fold(
      (exception) => failure = APIFailure.fromException(exception: exception),
      (res) => _application = res,
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // DELETE by applicationId
  Future<Failure?> deleteApplication({required String applicationId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.deleteApplication(applicationId: applicationId);
    result.fold(
      (exception) => failure = APIFailure.fromException(exception: exception),
      (ok) {
        if (ok) _application = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
