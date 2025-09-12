// lib/features/application/pdfModule/presentation/student_pdf_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import 'package:tc_sa/common/index.dart'
    show SAppBar, SIcon, SColor, STextStyles, SLoadingIndicator;
import 'package:tc_sa/core/index.dart' show ViewState, getIt, AppStateProvider, Toasts;

import 'package:tc_sa/features/application/pdfModule/presentation/view_models/pdf_view_model.dart';

class StudentPdfScreen extends StatefulWidget {
  const StudentPdfScreen({super.key});

  @override
  State<StudentPdfScreen> createState() => _StudentPdfScreenState();
}

class _StudentPdfScreenState extends State<StudentPdfScreen> {
  final vm = StudentPdfViewModel();

  String? get _studId => getIt<AppStateProvider>().user?.sId;

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
            appBar: const SAppBar(
              title: "Application PDF",
              leading: SIcon(icon: Icons.arrow_back),
            ),
            body: Column(
              children: [
                // Actions
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: busy
                              ? null
                              : () async {
                                  final err =
                                      await v.generate(context: context, studId: _studId);
                                  if (err != null) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: err.message ?? 'Failed',
                                    );
                                  }
                                },
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text("Generate"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SColor.primaryColor,
                            foregroundColor: Colors.white,
                            iconSize: 10
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: busy
                              ? null
                              : () async {
                                  final err =
                                      await v.view(context: context, studId: _studId);
                                  if (err != null) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: err.message ?? 'Failed',
                                    );
                                  } else if (v.localPdfPath == null &&
                                      v.message != null) {
                                    Toasts.showErrorToast(context, message: v.message!);
                                  }
                                },
                          icon: const Icon(Icons.visibility),
                          label: const Text("View"),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: busy
                              ? null
                              : () async {
                                  final err =
                                      await v.download(context: context, studId: _studId);
                                  if (err != null) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: err.message ?? 'Failed',
                                    );
                                  } else if (v.message != null) {
                                    // e.g., "Empty PDF"
                                    Toasts.showInfoToast(context, message: v.message!);
                                  }
                                },
                          
                          label: const Text("Download"),
                         
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Preview area
                Expanded(
                  child: busy
                      ? const Center(child: SLoadingIndicator())
                      : (v.localPdfPath == null)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  "Tap View to render your PDF here.\nYou can also Generate first (server will store/update).",
                                  textAlign: TextAlign.center,
                                  style: STextStyles.s14W400
                                      .copyWith(color: Colors.black54),
                                ),
                              ),
                            )
                          : PDFView(
                              filePath: v.localPdfPath!,
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: true,
                              pageFling: true,
                              onError: (e) => Toasts.showErrorToast(
                                context,
                                message: "PDF error: $e",
                              ),
                              onPageError: (p, e) => Toasts.showErrorToast(
                                context,
                                message: "Page $p: $e",
                              ),
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
