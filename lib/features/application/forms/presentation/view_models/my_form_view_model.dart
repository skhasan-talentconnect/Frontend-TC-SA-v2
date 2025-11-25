// lib/features/application/forms/presentation/view_models/my_form_view_model.dart
import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';
import 'package:tc_sa/features/application/forms/data/entities/form.dart';
import 'package:tc_sa/features/application/forms/data/data_source/form_data_source_impl.dart';
import 'package:tc_sa/features/application/forms/utils/enums.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/applied_form_model.dart';
import 'package:tc_sa/features/application/applications/data/data_source/application_data_source_impl.dart'; // <-- new

class MyFormViewModel extends ViewStateProvider {
  final FormDataSourceImpl formDataSourceImpl = FormDataSourceImpl();
  final ApplicationDataSourceImpl applicationDataSourceImpl = ApplicationDataSourceImpl(); // <-- new
  final NetworkService _network = getIt<NetworkService>();
  final AppStateProvider _app = getIt<AppStateProvider>();

  List<Form> _forms = [];
  List<Form> get forms => _forms;
  set forms(List<Form> val) {
    _forms = val;
    notifyListeners();
  }

  /// List of PDFs / applications available for the logged-in student.
  /// Each item is the raw JSON map returned by backend (contains _id, applicationId, createdAt, etc).
  List<Map<String, dynamic>> availablePdfs = [];

  /// Cache: applicationId -> StudentApplication
  final Map<String, StudentApplication> _applicationCache = {};
  Map<String, StudentApplication> get applicationCache => _applicationCache;

  /// Loading tracker for per-application fetches
  final Map<String, bool> _appLoading = {};
  bool isAppLoading(String applicationId) => _appLoading[applicationId] == true;

  Future<Failure?> getForms() async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await formDataSourceImpl.getStudentForms();
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        forms = res ?? [];
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }

  /// Fetch generated PDFs for the logged-in student.
  /// If studId provided, uses it; otherwise uses logged-in user's sId.
  /// Populates availablePdfs and returns Failure? (null on success).
  Future<Failure?> fetchStudentPdfs({String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final id = studId ?? _app.user?.sId;
    if (id == null || id.isEmpty) {
      failure = APIFailure(message: "Missing student id", statusCode: 400);
      setViewState(ViewState.complete);
      return failure;
    }

    try {
      // Use absolute URL to avoid NetworkService base behavior surprises
      final endpoint = 'https://backend-tc-sa-v2.onrender.com/api/users/list/$id';
      final req = Request(method: RequestMethod.get, endpoint: endpoint, isSafeRoute: true);
      final res = await _network.request(req);

      // Expecting backend response: { status: "success", message: "...", data: [ {...}, ... ] }
      final map = res.data as Map<String, dynamic>?;

      final list = (map != null && map['data'] is List) ? (map['data'] as List) : <dynamic>[];

      availablePdfs = list.map((e) {
        if (e is Map<String, dynamic>) return e;
        try {
          return Map<String, dynamic>.from(e as Map);
        } catch (_) {
          return <String, dynamic>{};
        }
      }).toList();

      // sort newest first (optional)
      availablePdfs.sort((a, b) {
        final da = a['createdAt']?.toString() ?? '';
        final db = b['createdAt']?.toString() ?? '';
        return db.compareTo(da);
      });
    } catch (e) {
      failure = APIFailure(message: "unknown", statusCode: 400);
    }

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  /// Fetch a single StudentApplication by applicationId and cache it.
  /// Returns Failure? (null on success)
  Future<Failure?> fetchApplicationById({required String applicationId}) async {
    if (applicationId.isEmpty) {
      return APIFailure(message: "Missing applicationId", statusCode: 400);
    }

    // already cached
    if (_applicationCache.containsKey(applicationId)) return null;

    Failure? failure;
    _appLoading[applicationId] = true;
    notifyListeners();

    try {
      final res = await applicationDataSourceImpl.getApplicationById(applicationId: applicationId);
      res.fold((exception) {
        failure = APIFailure.fromException(exception: exception);
      }, (app) {
        if (app != null) {
          _applicationCache[applicationId] = app;
        } else {
          // treat as not found
          failure = APIFailure(message: "Application not found", statusCode: 404);
        }
      });
    } catch (e) {
      failure = APIFailure(message: e.toString(), statusCode: 500);
    } finally {
      _appLoading.remove(applicationId);
      notifyListeners();
    }

    return failure;
  }

  /// Given the raw `pdfs` list (each item usually contains applicationId/_id),
  /// prefetch missing StudentApplication objects concurrently.
  Future<void> prefetchApplicationsForPdfs(List<Map<String, dynamic>> pdfs) async {
    if (pdfs.isEmpty) return;

    final futures = <Future>[];
    for (final p in pdfs) {
      final applicationId = (p['applicationId'] ?? p['_id'] ?? p['formId'] ?? '').toString();
      if (applicationId.isEmpty) continue;
      if (_applicationCache.containsKey(applicationId)) continue;

      futures.add(fetchApplicationById(applicationId: applicationId));
    }

    if (futures.isNotEmpty) {
      // await all but ignore individual failures (they are returned as Failure? but we don't need to bubble up here)
      await Future.wait(futures);
    }
  }

  Future<Failure?> submitForm({
    required String schoolId,
    required String applicationId,
    required String formId, // pdf id
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await formDataSourceImpl.submitForm(
      applicationId: applicationId,
      schoolId: schoolId,
      formId: formId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {
      // optionally store or update local state if needed
    });

    setViewState(ViewState.complete);
    return failure;
  }
}
