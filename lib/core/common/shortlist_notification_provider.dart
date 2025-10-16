import 'package:flutter/material.dart';

class ShortlistNotificationProvider extends ChangeNotifier {
  bool _hasNewShortlist = false;
  bool get hasNewShortlist => _hasNewShortlist;

  void notifyNewShortlist() {
    if (!_hasNewShortlist) {
      _hasNewShortlist = true;
      notifyListeners();
    }
  }

  void clearNotification() {
    if (_hasNewShortlist) {
      _hasNewShortlist = false;
      notifyListeners();
    }
  }
}