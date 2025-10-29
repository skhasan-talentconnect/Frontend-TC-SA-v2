import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/data/entities/index.dart';

class ProfileViewModel extends ViewStateProvider {
  final List<ProfileTileModel> _routes = [
    ProfileTileModel(
      path: RouteNames.registerSchool,
      name: 'Register Your School',
      icon: Icon(Icons.book, color: Colors.black),
    ),
    ProfileTileModel(
      path: RouteNames.resetPassword,
      name: 'Reset Password',
      icon: Icon(Icons.lock_reset, color: Colors.black),
    ),
    ProfileTileModel(
      path: RouteNames.addApplication,
      name: 'Fill Application Form',
      icon: Icon(Icons.assignment, color: Colors.black),
    ),
    ProfileTileModel(
      path: RouteNames.contactUs,
      name: 'Contact Us',
      icon: Icon(Icons.phone, color: Colors.black),
    ),
    ProfileTileModel(
      path:RouteNames.support ,
      name: 'Support',
      icon: Icon(Icons.support_agent, color: Colors.black),
    ),
    ProfileTileModel(
      name: 'Logout',
      icon: Icon(Icons.logout, color: Colors.black),
    ),
  ];
  List<ProfileTileModel> get routes => _routes;

  User? user = getIt<AppStateProvider>().user;

  String? get userLocation => '${user?.city}/${user?.state}';
}
