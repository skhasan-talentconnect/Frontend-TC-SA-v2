import 'package:tc_sa/core/network/typedef.dart';

abstract class StudentPdfDataSource {
  ResultFuture<bool> generatePdf({
    required String studId,
    required String applicationId,
  });

  ResultFuture<List<int>?> viewPdfBytes({
    required String studId,
    required String applicationId,
  });

  ResultFuture<List<int>?> downloadPdfBytes({
    required String studId,
    required String applicationId,
  });
}
