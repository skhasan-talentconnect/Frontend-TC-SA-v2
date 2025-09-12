import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show SButton, STextStyles, SColor;

class AuthButton extends StatelessWidget {
  const AuthButton({
    this.isLogin = true,
    required this.move,
    required this.onPressed,
    required this.onGooglePressed,
    super.key, required this.OnMobilePressed,
  });

  final bool isLogin;
  final VoidCallback onPressed;
  final VoidCallback onGooglePressed;
  final VoidCallback OnMobilePressed;
  final void Function(bool isLogin) move;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        spacing: 16,
        children: [
          SButton(
            label: isLogin ? 'Signin' : 'Signup',
            max: true,
            padding: EdgeInsets.symmetric(vertical: 12),
            onPressed: onPressed,
          ),
          
          SButton.outlined(
            label: '${isLogin ? 'Sign in' : 'Sign up'} with Google',
            max: true,
            padding: EdgeInsets.symmetric(vertical: 12),
            onPressed: onGooglePressed,
          ),
           SButton.outlined(
            label: '${isLogin ? 'Sign in with Mobile Number' : 'Sign up'}',
            max: true,
            padding: EdgeInsets.symmetric(vertical: 12),
            onPressed: OnMobilePressed,
          ),
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              move(!isLogin);
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${isLogin ? 'Don\'t' : 'Already'} have an account? ',
                    style: STextStyles.s18W400.copyWith(
                      color: SColor.secTextColor,
                    ),
                    children: [
                      TextSpan(
                        text: isLogin ? 'Sign Up' : 'Sign in',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
