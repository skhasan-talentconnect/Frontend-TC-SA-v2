import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/index.dart' show Form;

abstract class FormDataSource {
  ResultFuture<List<Form>?> getStudentForms();

  ResultFuture<List<Form>?> trackForm({required String formId});

  ResultFuture<Form?> getFormById({required String formId});

  ResultFuture<Form?> submitForm({
    required String applicationId,
    required String schoolId,
  });
}
