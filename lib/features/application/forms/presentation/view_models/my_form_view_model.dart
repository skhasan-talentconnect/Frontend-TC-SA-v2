import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/data/data_source/form_data_source_impl.dart';
import 'package:tc_sa/features/application/forms/data/entities/form.dart';

class MyFormViewModel extends ViewStateProvider {
  FormDataSourceImpl formDataSourceImpl = FormDataSourceImpl();

  List<Form> _forms = [];
  List<Form> get forms => _forms;
  set forms(List<Form> val) {
    _forms = val;
    notifyListeners();
  }

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

  Future<Failure?> submitForm({
    required String schoolId,
    required String applicationId,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await formDataSourceImpl.submitForm(
      applicationId: applicationId,
      schoolId: schoolId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
