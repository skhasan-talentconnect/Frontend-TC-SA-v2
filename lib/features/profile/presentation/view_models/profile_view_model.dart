import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/data/entities/index.dart';

class ProfileViewModel extends ViewStateProvider {
  final List<ProfileTileModel> _routes = [
    ProfileTileModel(
      path: RouteNames.registerSchool,
      name: 'Register Your School',
      icon: Icon(Icons.book),
    ),
    ProfileTileModel(
      path: RouteNames.resetPassword,
      name: 'Reset Password',
      icon: Icon(Icons.lock_reset),
    ),
    ProfileTileModel(
      path: RouteNames.addApplication,
      name: 'Fill Application Form',
      icon: Icon(Icons.assignment),
    ),
    ProfileTileModel(name: 'Contact Us', icon: Icon(Icons.phone)),
    ProfileTileModel(name: 'Support', icon: Icon(Icons.support_agent)),
    ProfileTileModel(name: 'Logout', icon: Icon(Icons.logout)),
  ];
  List<ProfileTileModel> get routes => _routes;

  User? user = getIt<AppStateProvider>().user;

  String? get userLocation => '${user?.city}/${user?.state}';
}
