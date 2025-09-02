import 'package:flutter/material.dart';

enum NavItem { home, blog, service, shortlist }

extension NavItemExt on NavItem {
  String get label {
    switch (this) {
      case NavItem.home:
        return 'Home';
      case NavItem.blog:
        return 'Blogs';
      case NavItem.service:
        return 'Services';
      case NavItem.shortlist:
        return 'Saved';
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case NavItem.home:
        return Icons.home;
      case NavItem.blog:
        return Icons.create;
      case NavItem.service:
        return Icons.miscellaneous_services;
      case NavItem.shortlist:
        return Icons.bookmark;
    }
  }

  IconData get unSelectedIcon {
    switch (this) {
      case NavItem.home:
        return Icons.home_outlined;
      case NavItem.blog:
        return Icons.create_outlined;
      case NavItem.service:
        return Icons.miscellaneous_services_outlined;
      case NavItem.shortlist:
        return Icons.bookmark_outline;
    }
  }
}
