// lib/features/detailPages/alumini/presentation/view_models/alumni_view_model.dart
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/alumini/data/data_source/data_source.dart';
import 'package:tc_sa/features/detailPages/alumini/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/alumini/data/entities/alumini_model.dart';

class AlumniViewModel extends ViewStateProvider {
  final AlumniDataSourceImpl _svc = AlumniDataSourceImpl();

  AlumniModel? _alumni;
  AlumniModel? get alumni => _alumni;

  String? _message;
  String? get message => _message;

  // GET
  Future<Failure?> getAlumniBySchool({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getAlumniBySchool(schoolId: schoolId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _alumni = null;
    }, (res) {
      _alumni = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // POST
  Future<Failure?> addAlumni({
    required String schoolId,
    required List<AlumniScoreItem> topAlumnis,
    required List<FamousAlumniItem> famousAlumnies,
    required List<AlumniScoreItem> alumnis,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.addAlumni(
      schoolId: schoolId,
      topAlumnis: topAlumnis,
      famousAlumnies: famousAlumnies,
      alumnis: alumnis,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _alumni = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // PUT
  Future<Failure?> updateAlumniBySchool({
    required String schoolId,
    List<AlumniScoreItem>? topAlumnis,
    List<FamousAlumniItem>? famousAlumnies,
    List<AlumniScoreItem>? alumnis,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.updateAlumniBySchool(
      schoolId: schoolId,
      topAlumnis: topAlumnis,
      famousAlumnies: famousAlumnies,
      alumnis: alumnis,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _alumni = res;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // DELETE
  Future<Failure?> deleteAlumniBySchool({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.deleteAlumniBySchool(schoolId: schoolId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
    }, (res) {
      _message = res; // e.g., "Alumni data deleted successfully"
      _alumni = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
