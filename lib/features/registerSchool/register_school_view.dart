import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tc_sa/common/index.dart' show SAppBar, SColor, STextStyles;
import 'package:tc_sa/core/index.dart' show Toasts;

class SchoolRegistrationInfoPage extends StatelessWidget {
  const SchoolRegistrationInfoPage({super.key});


  static const String _registerUrl = 'https://smart-school-finder.netlify.app/';

  Future<void> _openRegisterLink(BuildContext context) async {
    final uri = Uri.parse(_registerUrl);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      Toasts.showErrorToast(context, message: 'Could not open the link.');
    }
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: STextStyles.s14W400)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SAppBar(title: 'Partner with Us'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Grow your school with our platform',
                  style: STextStyles.s16W400.copyWith(color: SColor.secTextColor)),
              const SizedBox(height: 8),
              Text(
                'Join our discovery and admissions network to reach the right parents, '
                'showcase your strengths, and simplify the application process.',
                style: STextStyles.s14W400,
              ),

              const SizedBox(height: 20),
              Text('Why register?',
                  style: STextStyles.s16W600.copyWith(color: SColor.secTextColor)),
              const SizedBox(height: 8),
              _bullet('Get a verified profile visible to thousands of parents.'),
              _bullet('Publish fees, facilities, photos, and admission updates.'),
              _bullet('Receive enquiries and manage applications in one place.'),
              _bullet('Free onboarding – quick setup, no tech team needed.'),

              const SizedBox(height: 20),
              Text('How it works',
                  style: STextStyles.s16W600.copyWith(color: SColor.secTextColor)),
              const SizedBox(height: 8),
              _bullet('Tap the button below to go to our secure web portal.'),
              _bullet('Create your admin account and verify school details.'),
              _bullet('Our team reviews & activates your listing within 24–48 hrs.'),

              const SizedBox(height: 20),
              // Inline highlighted link in paragraph (uses custom toast on failure)
              Text.rich(
                TextSpan(
                  style: STextStyles.s14W400,
                  children: [
                    const TextSpan(text: 'Ready to start? Tap '),
                    TextSpan(
                      text: 'register school on web',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _openRegisterLink(context),
                    ),
                    const TextSpan(text: ' or use the button below.'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Card(
                elevation: 0,
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.blue.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Register your school on our website',
                        textAlign: TextAlign.center,
                        style: STextStyles.s16W600.copyWith(color: SColor.secTextColor),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _openRegisterLink(context),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Register School on Web'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'You’ll be redirected to our secure web portal to complete registration.',
                        textAlign: TextAlign.center,
                        style: STextStyles.s12W400.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
