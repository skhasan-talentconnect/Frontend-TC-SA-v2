// lib/features/auth/otp/presentation/pages/add_phone_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart' show SAppBar, SIcon, STextStyles, SColor;

import 'package:tc_sa/core/index.dart' show RouteNames, ViewState;
import 'package:tc_sa/features/auth/mobileOtp/presentation/view_model/otp_view_model.dart';

class AddPhoneView extends StatefulWidget {
  const AddPhoneView({super.key});
  @override
  State<AddPhoneView> createState() => _AddPhoneViewState();
}

class _AddPhoneViewState extends State<AddPhoneView> {
  final _vm = OtpViewModel();
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _vm.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    final phone = _phoneCtrl.text.trim();
    final err = await _vm.sendOtp(phone, context: context);
    if (err == null && _vm.message == null && mounted) {
      context.pushNamed(RouteNames.addOtp, extra: phone);
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
              title: 'Register via Mobile',
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
                      'Enter your mobile number to receive an OTP.',
                      style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number (+91xxxxxxxxxx)',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      validator: (v) {
                        final t = (v ?? '').trim();
                        if (t.isEmpty) return 'Required';
                        // basic check; tweak as you need
                        if (!RegExp(r'^\+?\d{10,15}$').hasMatch(t)) return 'Invalid phone';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: busy ? null : _send,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SColor.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Send OTP'),
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
