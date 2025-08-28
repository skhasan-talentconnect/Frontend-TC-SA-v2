import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show STextStyles, SColor;

class AuthHeader extends StatelessWidget {
  const AuthHeader({this.isLogin = true, super.key});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Text(
          isLogin ? 'Login' : 'Signup',
          style: STextStyles.s24W600.copyWith(color: SColor.secTextColor),
        ),
        Text(
          'Please Enter your details to ${isLogin ? "Login" : "Signup"}',
          style: STextStyles.s16W400.copyWith(color: SColor.secTextColor),
        ),
      ],
    );
  }
}
