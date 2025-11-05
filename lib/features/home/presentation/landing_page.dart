import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _launchSchoolRegistration() async {
    const url = 'https://smart-school-finder.netlify.app/';
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Launch failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColor.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Image.asset(Assets.images.cropAppLogo.path, width: 250),
                  Text(
                    'AI-Powered School Discovery App',
                    textAlign: TextAlign.center,
                    style: STextStyles.s14W600.copyWith(
                      color: SColor.secTextColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SButton(
                label: 'SignUp / Login',
                max: true,
                onPressed: () {
                  context.pushNamed(RouteNames.loginRegister);
                },
              ),

              //
              // SButton.outlined(
              //   label: 'Register Your School',
              //   max: true,
              //   onPressed: _launchSchoolRegistration,
              // ),
              GestureDetector(
                onTap: () {
                  getIt<AppStateProvider>().user = User(
                    name: 'Guest',
                    shortlistedSchools: [],
                    userType: UserType.guest,
                  );
                  context.pushNamed(
                    RouteNames.addEditPreferences,
                    extra: false,
                  );
                },
                child: Text(
                  'Continue as Guest',
                  style: STextStyles.s18W600.copyWith(
                    color: SColor.secTextColor,
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
