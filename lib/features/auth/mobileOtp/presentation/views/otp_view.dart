// lib/features/auth/otp/presentation/pages/verify_otp_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart' show SAppBar, SIcon, STextStyles, SColor;
import 'package:tc_sa/core/index.dart' show RouteNames, ViewState;
import 'package:tc_sa/features/auth/mobileOtp/presentation/view_model/otp_view_model.dart';


class VerifyOtpView extends StatefulWidget {
  final String phone; // passed as extra from AddPhoneView
  const VerifyOtpView({super.key, required this.phone});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final _vm = OtpViewModel();
  final _formKey = GlobalKey<FormState>();
  final _otpCtrl = TextEditingController();

  @override
  void dispose() {
    _vm.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (!_formKey.currentState!.validate()) return;
 final err = await _vm.verifyOtp(
  phone: widget.phone,
  otp: _otpCtrl.text.trim(),
  context: context,
);

if (err.isRight() && mounted) {
  context.pushNamed(RouteNames.addEditPreferences,extra: false);
}
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Consumer<OtpViewModel>(
        builder: (_, v, __) {
          final busy = v.viewState == ViewState.busy;
          return Scaffold(
            appBar:  SAppBar(
              title: 'Verify OTP',
              actions: [],
             leading: SIcon(icon: Icons.keyboard_arrow_left,
          onTap: () => Navigator.of(context).pop())
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Enter the 6-digit OTP sent to ${widget.phone}.',
                      style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _otpCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'OTP',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      validator: (v) {
                        final t = (v ?? '').trim();
                        if (t.isEmpty) return 'Required';
                        if (!RegExp(r'^\d{4,8}$').hasMatch(t)) return 'Invalid OTP';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: busy ? null : _verify,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SColor.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Verify'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
