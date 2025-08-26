import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';
import 'package:tc_sa/features/auth/authentication/presentation/widgets/auth_header.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  AuthViewModel authViewModel = AuthViewModel();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authViewModel,
      child: Scaffold(
        body: Consumer<AuthViewModel>(
          builder: (vmContext, vm, _) {
            if (vm.isLoading) {
              return const Center(child: SLoadingIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthHeader(isLogin: vm.isLogin),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 24,
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
                      STextField(
                        controller: emailController,
                        label: 'Email*',
                        hint: 'Enter Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [
                          STextField.password(
                            controller: passController,
                            label: 'Password*',
                            hint: 'Enter Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordView(),
                                ),
                              );
                            },
                            child: Text(
                              ' Forgot Password?',
                              style: STextStyles.s14W400.copyWith(
                                color: SColor.secTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AuthButton(
                  isLogin: vm.isLogin,
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String pass = passController.text.trim();

                    if (email.isEmpty) {
                      Toasts.showInfoToast(
                        context,
                        message: 'Email is required.',
                      );
                    } else if (!Validator.validateEmail(email)) {
                      Toasts.showErrorToast(
                        context,
                        message: 'Please enter valid email.',
                      );
                    } else if (pass.isEmpty) {
                      Toasts.showInfoToast(
                        context,
                        message: 'Password is required.',
                      );
                    } else if (!Validator.validatePass(pass) &&
                        !authViewModel.isLogin) {
                      Toasts.showErrorToast(
                        context,
                        message:
                            'Password must contain lower & uppercase alphabets, digits & symbols.',
                      );
                    } else {
                      Failure? failure = await authViewModel.authenticate(
                        email: email,
                        password: pass,
                      );
                      Toasts.showSuccessOrFailureToast(
                        context,
                        failure: failure,
                      );
                    }
                  },
                  onGooglePressed: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn.instance;

                    await googleSignIn.initialize(
                      serverClientId:
                          '574038035729-6nlkp4a98fj3jdqkqlkub49asnskcnmh.apps.googleusercontent.com',
                    );

                    final GoogleSignInAccount? googleUser =
                        await googleSignIn.authenticate();

                    if (googleUser == null) {
                      throw FirebaseAuthException(
                        code: 'ERROR_ABORTED_BY_USER',
                        message: 'Sign in aborted by user',
                      );
                    }

                    // Obtain the auth details from the request
                    final GoogleSignInAuthentication googleAuth =
                        googleUser.authentication;

                    Failure? failure = await authViewModel.googleLogin(
                      tokenId: googleAuth.idToken ?? '',
                    );

                    Toasts.showSuccessOrFailureToast(context, failure: failure);
                  },
                  move: (isLogin) {
                    emailController.text = '';
                    passController.text = '';
                    FocusManager.instance.primaryFocus?.unfocus();
                    vm.isLogin = isLogin;
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
