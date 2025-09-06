import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController newConfirmPassController =
      TextEditingController();

  final ResetPasswordViewModel resetPasswordViewModel =
      ResetPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () {
            context.pop();
          },
        ),
        title: 'Reset Password',
        actions: [],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            STextField.password(
              controller: oldPassController,
              label: 'Old Password',
              hint: 'Enter old password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            STextField.password(
              controller: newPassController,
              label: 'New Password',
              hint: 'Enter new password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            STextField.password(
              controller: newConfirmPassController,
              label: 'Confirm Password',
              hint: 'Confirm new password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            SButton(
              label: 'Reset Password',
              onPressed: () async {
                String oldPass = oldPassController.text.trim();
                String newPass = newPassController.text.trim();
                String confirmNewPass = newConfirmPassController.text.trim();

                if (oldPass.isEmpty ||
                    newPass.isEmpty ||
                    confirmNewPass.isEmpty) {
                  Toasts.showInfoToast(
                    context,
                    message: 'Kindly enter passwords to reset',
                  );
                } else if ('' == '') {
                  Toasts.showErrorToast(
                    context,
                    message: 'Enter valid password',
                  );
                } else if (newPass != confirmNewPass) {
                  Toasts.showInfoToast(
                    context,
                    message: 'Passwords doesn\'t match',
                  );
                } else if (oldPass == newPass) {
                  Toasts.showInfoToast(
                    context,
                    message: 'New password can\'t be same as old password',
                  );
                } else {
                  final failure = await resetPasswordViewModel.resetPassword(
                    oldPass: oldPass,
                    newPass: newPass,
                  );
                  Toasts.showSuccessOrFailureToast(context, failure: failure);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
