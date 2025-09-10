// lib/features/application/pdfModule/presentation/view_models/student_pdf_view_model.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tc_sa/core/index.dart'
    show ViewState, ViewStateProvider, Failure, APIFailure, getIt, Toasts, APIException;
import 'package:tc_sa/core/index.dart' show AppStateProvider;
import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source.dart';
import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source_impl.dart';


class StudentPdfViewModel extends ViewStateProvider {
  final StudentPdfDataSource _ds = getIt<StudentPdfDataSourceImpl>();
  final AppStateProvider _app = getIt<AppStateProvider>();

  String? _localPdfPath;
  String? get localPdfPath => _localPdfPath;

  String? message;

  /// Generate & store PDF in backend
  Future<Failure?> generate({BuildContext? context, String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final id = studId ?? _app.user?.sId ?? '';
    final result = await _ds.generatePdf(studId: id);
    result.fold(
      (ex) => failure = APIFailure.fromException(exception: ex),
      (ok) {
        if (ok == true) {
          if (context != null) {
            Toasts.showSuccessToast(context, message: 'PDF generated successfully.');
          }
        } else {
          message = 'Failed to generate PDF';
          if (context != null) {
            Toasts.showErrorToast(context, message: message!);
          }
        }
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  /// Fetch PDF bytes for inline viewing; writes to a temp file.
  Future<Failure?> view({BuildContext? context, String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final id = studId ?? _app.user?.sId ?? '';
    final result = await _ds.viewPdfBytes(studId: id);
    await result.fold(
      (ex) async {
        failure = APIFailure.fromException(exception: ex);
        if (context != null) {
          Toasts.showErrorToast(context, message: failure!.message ?? 'Failed to load PDF');
        }
      },
      (bytes) async {
        if (bytes == null || bytes.isEmpty) {
          message = 'Empty PDF';
          if (context != null) {
            Toasts.showInfoToast(context, message: message!);
          }
          return;
        }
        final tmp = await getTemporaryDirectory();
        final path = '${tmp.path}/student_view.pdf';
        await File(path).writeAsBytes(bytes, flush: true);
        _localPdfPath = path;
        if (context != null) {
          Toasts.showSuccessToast(context, message: 'PDF ready to view.');
        }
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }


/// Download PDF bytes and save to app docs dir
  Future<Failure?> download({BuildContext? context, String? studId}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final id = studId ?? _app.user?.sId ?? '';
    final result = await _ds.downloadPdfBytes(studId: id);
    await result.fold(
      (ex) async {
        failure = APIFailure.fromException(exception: ex);
        if (context != null) {
          Toasts.showErrorToast(context, message: failure!.message ?? 'Download failed');
        }
      },
      (bytes) async {
        if (bytes == null || bytes.isEmpty) {
          message = 'Empty PDF';
          if (context != null) {
            Toasts.showInfoToast(context, message: message!);
          }
          return;
        }
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/student_${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(bytes, flush: true);
        if (context != null) {
          Toasts.showInfoToast(context, message: 'Saved to: ${file.path}');
        }
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  void clearLocalPath() {
    _localPdfPath = null;
    notifyListeners();
  }
}
