import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/themes.dart';

class AppThemes {
  static final Map<AppTheme, AppColorTheme> themes = {
    AppTheme.themeA: const AppColorTheme(
      backgroundColor: Color(0xffffffff),
      textColor: Color(0xff000000),
      secTextColor: Color(0xff222222),
      terTextColor: Color(0xff404040),
      primaryColor: Color(0xff000000),
      borderColor: Color(0xff000000),
    ),

    AppTheme.themeB: const AppColorTheme(
      backgroundColor: Color(0xff121212),
      textColor: Color(0xffffffff),
      secTextColor: Color(0xffcccccc),
      terTextColor: Color(0xffaaaaaa),
      primaryColor: Color(0xff1e88e5),
      borderColor: Color(0xffffffff),
    ),

    AppTheme.themeC: const AppColorTheme(
      backgroundColor: Color(0xfff7fff7),
      textColor: Color(0xff1b5e20),
      secTextColor: Color(0xff2e7d32),
      terTextColor: Color(0xff4caf50),
      primaryColor: Color(0xff4caf50),
      borderColor: Color(0xff4caf50),
    ),

    AppTheme.themeD: const AppColorTheme(
      backgroundColor: Color(0xfffff8f1),
      textColor: Color(0xff4e342e),
      secTextColor: Color(0xff6d4c41),
      terTextColor: Color(0xff8d6e63),
      primaryColor: Color(0xffff5722),
      borderColor: Color(0xffff5722),
    ),
  };
}
