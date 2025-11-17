// lib/features/application/forms/presentation/view_models/my_form_view_model.dart
import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/data/entities/form.dart';
import 'package:tc_sa/features/application/forms/data/data_source/form_data_source_impl.dart';
import 'package:tc_sa/features/application/forms/utils/enums.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/applied_form_model.dart';

class MyFormViewModel extends ViewStateProvider {
  final FormDataSourceImpl formDataSourceImpl = FormDataSourceImpl();
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
