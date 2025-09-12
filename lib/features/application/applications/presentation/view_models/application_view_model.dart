// lib/features/applications/presentation/view_models/application_view_model.dart
import 'package:tc_sa/core/index.dart' show ViewState, ViewStateProvider, Failure, getIt, APIFailure;
import 'package:tc_sa/features/application/applications/data/data_source/application_data_source.dart';
import 'package:tc_sa/features/application/applications/data/data_source/application_data_source_impl.dart';
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';

class ApplicationViewModel extends ViewStateProvider {
  final ApplicationDataSource _ds = getIt<ApplicationDataSourceImpl>();

  StudentApplication? _application;
  StudentApplication? get application => _application;

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
      (err) => failure = err as Failure?,
      (res) => _applications = res,
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // GET BY studId (defaults to logged-in)
  Future<Failure?> getApplicationByStudId({String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.getApplicationByStudId(studId: studId);
       
result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
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

  // UPDATE (by studId)
  Future<Failure?> updateApplication(StudentApplication payload, {String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.updateApplication(payload: payload, studId: studId);
    result.fold(
      (err) => failure = err as Failure?,
      (res) => _application = res,
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // DELETE (by studId)
  Future<Failure?> deleteApplication({String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _ds.deleteApplication(studId: studId);
    result.fold(
      (err) => failure = err as Failure?,
      (ok) {
        if (ok) _application = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
