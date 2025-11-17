// lib/features/application/forms/presentation/view_models/form_details_view_model.dart

import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/data/data_source/form_data_source_impl.dart';
import 'package:tc_sa/features/application/forms/data/entities/form.dart';

class FormDetailsViewModel extends ViewStateProvider {
  final FormDataSourceImpl _dataSource = FormDataSourceImpl();

  Form? _form;
  Form? get form => _form;
  set form(Form? v) {
    _form = v;
    notifyListeners();
  }

  Future<Failure?> getFormById({required String formId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _dataSource.getFormById(formId: formId);
    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {
      form = res;
    });

    setViewState(ViewState.complete);
    return failure;
  }
}
