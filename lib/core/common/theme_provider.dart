import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tc_sa/common/theme/index.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = "selected_theme";

  AppTheme _current = AppTheme.themeA;

  AppColorTheme get colors => AppThemes.themes[_current]!;

  AppTheme get current => _current;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> setTheme(AppTheme theme) async {
    _current = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, theme.index);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key);

    if (index != null && index < AppTheme.values.length) {
      _current = AppTheme.values[index];
      notifyListeners();
    }
  }
}
