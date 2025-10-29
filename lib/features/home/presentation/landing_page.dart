import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _launchSchoolRegistration() async {
    const url = 'https://smart-school-finder.netlify.app/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
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
              Text(
                'Synzy',
                style: STextStyles.s30W900.copyWith(color: SColor.secTextColor),
              ),
              Container(
                height: 350,
                color: Colors.grey,
                child: Center(
                  child: Icon(Icons.image, color: Colors.grey.shade700),
                ),
              ),
              
              // 🔹 Existing Login/Signup button
              SButton(
                label: 'SignUp / Login',
                max: true,
                onPressed: () {
                  context.pushNamed(RouteNames.loginRegister);
                },
              ),

              // 🔹 New "Register Your School" button
              SButton.outlined(
                label: 'Register Your School',
                max: true,
                onPressed: _launchSchoolRegistration,
              ),

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
