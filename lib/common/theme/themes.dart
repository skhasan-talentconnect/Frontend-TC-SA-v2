import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/themes.dart'; // keep if you need it elsewhere

enum AppTheme { themeA, themeB, themeC, themeD }

extension AppThemeExt on AppTheme {
  String get label {
    switch (this) {
      case AppTheme.themeA:
        return 'Amber';
      case AppTheme.themeB:
        return 'Midnight';
      case AppTheme.themeC:
        return 'Forest';
      case AppTheme.themeD:
        return 'Warm';
    }
  }
}

class AppColorTheme {
  final Color backgroundColor;
  final Color primaryColor;
  final Color borderColor;
  final Color textColor;
  final Color secTextColor;
  final Color terTextColor;
  final Color boxShadowColor;
  final Color topTextColor;
  final Color greyShadowColor;
  final Color bottomTextColor;
  final Color amberColor;
  final Color borderSideColor;
  final Color amberMedColor;
  final Color amberLightColor;
  final Color amberDarkColor;

  const AppColorTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.secTextColor,
    required this.terTextColor,
    required this.primaryColor,
    required this.borderColor,
    required this.boxShadowColor,
    required this.topTextColor,
    required this.greyShadowColor,
    required this.bottomTextColor,
    required this.amberColor,
    required this.borderSideColor,
    required this.amberMedColor,
    required this.amberLightColor,
    required this.amberDarkColor,
  });
}
