import 'package:flutter/cupertino.dart';

class ProfileTileModel {
  String? path;
  String? name;
  Widget? icon;
  VoidCallback? onTap;

  ProfileTileModel({this.path, this.name, this.icon, this.onTap});
}
