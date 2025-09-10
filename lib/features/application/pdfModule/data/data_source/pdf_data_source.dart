// lib/features/application/pdfModule/data/data_source/pdf_data_source.dart
import 'package:tc_sa/core/index.dart' show ResultFuture;

abstract class StudentPdfDataSource {
  /// POST /pdf/generate/:studId -> { message, pdfId }
  ResultFuture<bool> generatePdf({String? studId});

  /// GET /pdf/view/:studId -> bytes (inline pdf)
  ResultFuture<List<int>?> viewPdfBytes({String? studId});

  /// GET /pdf/download/:studId -> bytes (attachment)
  ResultFuture<List<int>?> downloadPdfBytes({String? studId});
}
