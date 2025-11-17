import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles;
import 'package:tc_sa/core/index.dart' show RouteNames, getIt, AppStateProvider;
class ApplicationSuccessView extends StatelessWidget {
  final String? applicationId; // now nullable
  const ApplicationSuccessView({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context) {
    final studId = getIt<AppStateProvider>().user?.sId;
    final hasValidAppId = applicationId != null && applicationId!.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 16),
                Text("Application Submitted!",
                    style:
                        STextStyles.s20W400.copyWith(color: SColor.secTextColor)),
                const SizedBox(height: 8),
                Text(
                  "Your application was submitted successfully.\nYou can now generate your pdf from the appication dashboard",
                  textAlign: TextAlign.center,
                  style: STextStyles.s14W400.copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 32),

                // VIEW PDF BUTTON — disabled when no valid id
               
                const SizedBox(height: 12),
                TextButton(
  onPressed: () {
    context.pushNamed(RouteNames.addApplication); 
  },
  child: const Text("Go Back to Dashboard"),
)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
