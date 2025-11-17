import 'package:flutter/material.dart';

enum AppTheme { themeA, themeB, themeC, themeD }

extension AppThemeExt on AppTheme {
  String get label {
    switch (this) {
      case AppTheme.themeA:
        return 'Theme A';
      case AppTheme.themeB:
        return 'Theme B';
      case AppTheme.themeC:
        return 'Theme C';
      case AppTheme.themeD:
        return 'Theme D';
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

  const AppColorTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.secTextColor,
    required this.terTextColor,
    required this.primaryColor,
    required this.borderColor,
  });
}
