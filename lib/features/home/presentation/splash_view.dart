import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/theme/s_colors.dart';
import 'package:tc_sa/common/theme/styles.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/core/services/secret_repo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String next = RouteNames.loginRegister; // default
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  bool _minTimePassed = false;
  bool _logicDone = false;

  final appStateProvider = getIt<AppStateProvider>();

  @override
  void initState() {
    super.initState();

    // ensure at least 2s splash
    Future.delayed(const Duration(seconds: 2), () {
      _minTimePassed = true;
      isLoading.value = true; // switch to loader if still waiting
      _tryNavigate();
    });

    _decideNext();
  }

  Future<void> _decideNext() async {
    String token = await SecretRepo.getString('auth_token') ?? '';

    if (token.isNotEmpty) {
      try {
        await appStateProvider.getUserDetails();
        await appStateProvider.getAuthDetails();
        if (appStateProvider.user != null &&
            appStateProvider.authModel != null) {
          next = RouteNames.home;
        } else if (appStateProvider.user == null &&
            appStateProvider.authModel != null) {
          next = RouteNames.addEditProfile;
        } else {
          print('Removing token from else');
          await SecretRepo.remove('auth_token');
          next = RouteNames.loginRegister;
        }
      } catch (e) {
        print('Removing token from catch');
        await SecretRepo.remove('auth_token');
        next = RouteNames.loginRegister;
      }
    }

    _logicDone = true;
    _tryNavigate();
  }

  void _tryNavigate() {
    if (_minTimePassed && _logicDone && mounted) {
      context.pushReplacementNamed(next, extra: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder:
            (_, loading, __) => Center(
              child:
                  loading
                      ? SLoadingIndicator()
                      : Text(
                        'Splash Page',
                        style: STextStyles.s22W600.copyWith(
                          color: SColor.secTextColor,
                        ),
                      ),
            ),
      ),
    );
  }
}
