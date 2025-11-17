import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tc_sa/core/index.dart'
    show ViewState, ViewStateProvider, Failure, APIFailure, getIt, Toasts, AppStateProvider;

import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source.dart';
import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source_impl.dart';

class StudentPdfViewModel extends ViewStateProvider {
  final StudentPdfDataSource _ds = getIt<StudentPdfDataSourceImpl>();

  String? selectedApplicationId;
  void setSelectedApplicationId(String id) {
    selectedApplicationId = id;
    notifyListeners();
  }

  String? _localPdfPath;
  String? get localPdfPath => _localPdfPath;
final studId = getIt<AppStateProvider>().user?.sId;
  String? message;

  // -------------------------------------------------------------
Future<Failure?> generate({
  BuildContext? context,
  String? applicationId,
  String? studId,
}) async {
  setViewState(ViewState.busy);
  Failure? failure;

  final sid = studId ?? getIt<AppStateProvider>().user?.sId;
  final aid = applicationId ?? selectedApplicationId;

  if (sid == null || aid == null) {
    message = "Missing studId or applicationId";
    setViewState(ViewState.complete);
    notifyListeners();
    return null;
  }

  final result = await _ds.generatePdf(
    studId: sid,            // now String
    applicationId: aid,     // now String
  );

  result.fold(
    (ex) => failure = APIFailure.fromException(exception: ex),
    (ok) {
      if (context != null) {
        Toasts.showSuccessToast(
          context,
          message: "PDF generated successfully",
        );
      }
    },
  );

  setViewState(ViewState.complete);
  notifyListeners();
  return failure;
}

  // -------------------------------------------------------------
Future<Failure?> view({
  BuildContext? context,
  String? applicationId,
  String? studId,
}) async {
  setViewState(ViewState.busy);
  Failure? failure;

  final sid = studId ?? getIt<AppStateProvider>().user?.sId;
  final aid = applicationId ?? selectedApplicationId;

  if (sid == null || aid == null) {
    message = "Missing studId or applicationId";
    setViewState(ViewState.complete);
    notifyListeners();
    return null;
  }

  final result = await _ds.viewPdfBytes(
    studId: sid,
    applicationId: aid,
  );

  await result.fold(
    (ex) async {
      failure = APIFailure.fromException(exception: ex);
      if (context != null) {
        Toasts.showErrorToast(context, message: failure!.message ?? "Failed");
      }
    },
    (bytes) async {
      if (bytes == null || bytes.isEmpty) {
        message = "Empty PDF";
        if (context != null) {
          Toasts.showInfoToast(context, message: message!);
        }
        return;
      }

      final tmp = await getTemporaryDirectory();
      final path = '${tmp.path}/application_${aid}_view.pdf';
      await File(path).writeAsBytes(bytes, flush: true);

      _localPdfPath = path;
    },
  );

  setViewState(ViewState.complete);
  notifyListeners();
  return failure;
}

  // -------------------------------------------------------------
Future<Failure?> download({
  BuildContext? context,
  String? applicationId,
  String? studId,
}) async {
  setViewState(ViewState.busy);
  Failure? failure;

  final sid = studId ?? getIt<AppStateProvider>().user?.sId;
  final aid = applicationId ?? selectedApplicationId;

  if (sid == null || aid == null) {
    message = "Missing studId or applicationId";
    setViewState(ViewState.complete);
    notifyListeners();
    return null;
  }

  final result = await _ds.downloadPdfBytes(
    studId: sid,
    applicationId: aid,
  );

  await result.fold(
    (ex) async {
      failure = APIFailure.fromException(exception: ex);
      if (context != null) {
        Toasts.showErrorToast(context, message: failure!.message ?? "Failed");
      }
    },
    (bytes) async {
      if (bytes == null || bytes.isEmpty) {
        message = "Empty PDF";
        if (context != null) {
          Toasts.showInfoToast(context, message: message!);
        }
        return;
      }

      final dir = await getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/application_${aid}_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      await file.writeAsBytes(bytes, flush: true);
      if (context != null) {
        Toasts.showSuccessToast(
          context,
          message: "Saved to: ${file.path}",
        );
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
