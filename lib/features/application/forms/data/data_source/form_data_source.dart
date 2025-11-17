import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/application/forms/data/entities/form.dart';

abstract class FormDataSource {
  ResultFuture<List<Form>?> getStudentForms();

  ResultFuture<List<Form>?> trackForm({required String formId});

  ResultFuture<Form?> getFormById({required String formId});

  // now requires formId
  ResultFuture<Form?> submitForm({
    required String applicationId,
    required String schoolId,
    required String formId,
  });
}
