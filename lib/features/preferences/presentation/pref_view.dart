import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

import '../../users/preference/pref_view_model.dart';

class PrefView extends StatefulWidget {
  const PrefView({super.key});

  @override
  State<PrefView> createState() => _PrefViewState();
}

class _PrefViewState extends State<PrefView> {
  final standardController = TextEditingController();
  final interestController = TextEditingController();
  final schoolTypeController = TextEditingController();
  final shiftController = TextEditingController();

  final PrefViewModel prefViewModel = PrefViewModel();

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
        title: 'Add/Edit Preferences',
      ),

      body: ChangeNotifierProvider.value(
        value: prefViewModel,
        child: Consumer<PrefViewModel>(
          builder:
              (vmContext, vm, __) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  spacing: 16,
                  children: [
                    STextField.dropdown(
                      controller: standardController,
                      items: [
                        'PlaySchool',
                        'Pre-Primary',
                        'Primary',
                        'Secondary',
                      ],
                      label: 'Preferred Standard',
                      hint: 'Select Standard',
                    ),
                    STextField.dropdown(
                      controller: interestController,
                      items: [
                        'Focusing on Academics',
                        'Focuses on Practical Learning',
                        'Focuses on Theoretical Learning',
                        'Empowering in Sports',
                        'Empowering in Arts',
                        'Special Focus on Mathematics',
                        'Special Focus on Science',
                        'Special Focus on Physical Education',
                        'Leadership Development',
                        'STEM Activities',
                        'Cultural Education',
                        'Technology Integration',
                        'Environmental Awareness',
                      ],
                      label: 'Interests',
                      hint: 'Select Interest',
                    ),
                    STextField.dropdown(
                      controller: schoolTypeController,
                      items: ['Convent', 'Private', 'Government'],
                      label: 'Preferred School Type',
                      hint: 'Select School Type',
                    ),
                    STextField.dropdown(
                      controller: shiftController,
                      items: ['Morning', 'Afternoon', 'Night school'],
                      label: 'Preferred Shifts',
                      hint: 'Select Shift',
                    ),
                    SButton(
                      label: 'Submit',
                      onPressed: () async {
                        String standard = standardController.text.trim();
                        String interest = interestController.text.trim();
                        String schoolType = schoolTypeController.text.trim();
                        String shifts = shiftController.text.trim();

                        if (standard.isEmpty ||
                            interest.isEmpty ||
                            schoolType.isEmpty ||
                            shifts.isEmpty) {
                          Toasts.showErrorToast(
                            context,
                            message: 'Please fill all the fields',
                          );
                        } else {
                          Toasts.showInfoToast(
                            context,
                            message: 'Feature is in development',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
