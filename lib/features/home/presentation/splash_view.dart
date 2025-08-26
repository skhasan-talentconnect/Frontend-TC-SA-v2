import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      context.pushNamed(RouteNames.loginRegister);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Page',
          style: STextStyles.s22W600.copyWith(color: SColor.secTextColor),
        ),
      ),
    );
  }
}
