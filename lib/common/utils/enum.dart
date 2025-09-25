import 'package:flutter/material.dart';

enum NavItem { home, blog, preferences, shortlist, myForms }

extension NavItemExt on NavItem {
  String get label {
    switch (this) {
      case NavItem.home:
        return 'Home';
      case NavItem.blog:
        return 'Blogs';
      case NavItem.preferences:
        return 'Edit Preferences';
      case NavItem.shortlist:
        return 'Saved';
      case NavItem.myForms:
        return 'Applications';
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case NavItem.home:
        return Icons.home;
      case NavItem.blog:
        return Icons.assessment;
      case NavItem.preferences:
        return Icons.edit;
      case NavItem.shortlist:
        return Icons.bookmark;
      case NavItem.myForms:
        return Icons.assignment;
    }
  }

  IconData get unSelectedIcon {
    switch (this) {
      case NavItem.home:
        return Icons.home_outlined;
      case NavItem.blog:
        return Icons.assessment_outlined;
      case NavItem.preferences:
        return Icons.edit_outlined;
      case NavItem.shortlist:
        return Icons.bookmark_outline;
      case NavItem.myForms:
        return Icons.assignment_outlined;
    }
  }
}
