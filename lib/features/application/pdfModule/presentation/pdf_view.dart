// lib/features/application/pdfModule/presentation/student_pdf_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import 'package:tc_sa/common/index.dart'
    show SAppBar, SIcon, SColor, STextStyles, SLoadingIndicator;
import 'package:tc_sa/core/index.dart'
    show ViewState, Toasts, getIt, AppStateProvider;

import 'package:tc_sa/features/application/pdfModule/presentation/view_models/pdf_view_model.dart';

class StudentPdfScreen extends StatefulWidget {
  final String? applicationId;
  final bool download;

  const StudentPdfScreen({
    super.key,
    this.applicationId,
    this.download = false,
  });

  @override
  State<StudentPdfScreen> createState() => _StudentPdfScreenState();
}

class _StudentPdfScreenState extends State<StudentPdfScreen> {
  final StudentPdfViewModel vm = StudentPdfViewModel();

  String? get studId => getIt<AppStateProvider>().user?.sId;

  @override
  void initState() {
    super.initState();

    // Pre-select this application if passed
    if (widget.applicationId != null) {
      vm.setSelectedApplicationId(widget.applicationId!);

      // Auto-download if requested
      if (widget.download) {
        Future.microtask(() async {
          final err = await vm.download(
            context: context,
            studId: studId,
            applicationId: widget.applicationId,
          );
          if (err != null) {
            Toasts.showErrorToast(context, message: err.message ?? "Failed");
          }
        });
      }
    }
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<StudentPdfViewModel>(
        builder: (_, v, __) {
          final busy = v.viewState == ViewState.busy;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: SAppBar(
              title: "Application PDF",
              leading: SIcon(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            ),

            body: Column(
              children: [
                // ACTION BAR
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      // GENERATE
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: busy
                              ? null
                              : () async {
                                  final err = await v.generate(
                                    context: context,
                                    studId: studId!,
                                    applicationId:
                                        v.selectedApplicationId ?? widget.applicationId!,
                                  );
                                  if (err != null) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: err.message ?? "Failed",
                                    );
                                  }
                                },
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text("Generate"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SColor.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),

                      // VIEW
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: busy
                              ? null
                              : () async {
                                  final err = await v.view(
                                    context: context,
                                    studId: studId!,
                                    applicationId:
                                        v.selectedApplicationId ?? widget.applicationId!,
                                  );
                                  if (err != null) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: err.message ?? "Failed",
                                    );
                                  }
                                },
                          icon: const Icon(Icons.visibility),
                          label: const Text("View"),
                        ),
                      ),

                      const SizedBox(width: 6),

                      // DOWNLOAD
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: busy
                              ? null
                              : () async {
                                  final err = await v.download(
                                    context: context,
                                    studId: studId!,
                                    applicationId:
                                        v.selectedApplicationId ?? widget.applicationId!,
                                  );
                                  if (err != null) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: err.message ?? "Failed",
                                    );
                                  } else if (v.message != null) {
                                    Toasts.showInfoToast(context, message: v.message!);
                                  }
                                },
                          icon: const Icon(Icons.download),
                          label: const Text("Download"),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // PDF VIEWER
                Expanded(
                  child: busy
                      ? const Center(child: SLoadingIndicator())
                      : (v.localPdfPath == null)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  "Tap View to display the PDF.\nOr Generate to regenerate it.",
                                  textAlign: TextAlign.center,
                                  style: STextStyles.s14W400.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            )
                          : PDFView(
                              filePath: v.localPdfPath!,
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: true,
                              pageFling: true,
                              onError: (e) =>
                                  Toasts.showErrorToast(context, message: "Error: $e"),
                              onPageError: (page, err) =>
                                  Toasts.showErrorToast(context, message: "Page $page: $err"),
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
