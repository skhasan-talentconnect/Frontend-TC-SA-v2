import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordView();
}

class _ForgotPasswordView extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController newConfirmPassController =
      TextEditingController();

  final ForgotPasswordViewModel forgotPasswordViewModel =
      ForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: forgotPasswordViewModel,
      child: Scaffold(
        appBar: SAppBar(title: 'Forget Password', actions: []),

        body: Consumer<ForgotPasswordViewModel>(
          builder: (_, forgotPasswordViewModel, __) {
            if (forgotPasswordViewModel.isLoading) {
              return const Center(child: SLoadingIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  STextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  if (forgotPasswordViewModel.isVerified) ...[
                    Column(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 0),
                        STextField(
                          controller: otpController,
                          label: 'OTP',
                          hint: 'Enter OTP',
                          prefixIcon: Icon(Icons.password),
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
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  SButton(
                    label:
                        forgotPasswordViewModel.isVerified
                            ? 'Reset Password'
                            : 'Send OTP',
                    onPressed: () async {
                      String email = emailController.text.trim();

                      if (email.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Kindly enter email.',
                        );
                      } else if (!Validator.validateEmail(email)) {
                        Toast.showErrorToast(
                          context,
                          message: 'Please enter valid email.',
                        );
                      } else {
                        if (forgotPasswordViewModel.isVerified) {
                          String otp = otpController.text.trim();
                          String newPass = newPassController.text.trim();
                          String confirmNewPass =
                              newConfirmPassController.text.trim();

                          if (otp.isEmpty) {
                            Toast.showErrorToast(context, message: 'Enter OTP');
                          } else if (otp.length != 6) {
                            Toast.showErrorToast(
                              context,
                              message: 'Please enter valid OTP',
                            );
                          } else if (newPass.isEmpty ||
                              confirmNewPass.isEmpty) {
                            Toast.showInfoToast(
                              context,
                              message: 'Kindly enter passwords to reset',
                            );
                          } else if (!Validator.validatePass(newPass)) {
                            Toast.showErrorToast(
                              context,
                              message:
                                  'Password must contain lower & uppercase alphabets, digits & symbols.',
                            );
                          } else if (newPass != confirmNewPass) {
                            Toast.showInfoToast(
                              context,
                              message: 'Passwords doesn\'t match',
                            );
                          } else {
                            final failure = await forgotPasswordViewModel
                                .forgetPassVerifyOtp(
                                  email: email,
                                  otp: otp,
                                  password: confirmNewPass,
                                );

                            failure?.showError(context);
                          }
                        } else {
                          final failure = await forgotPasswordViewModel
                              .forgetPasswordSendOtp(email: email);

                          failure?.showError(context);
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
