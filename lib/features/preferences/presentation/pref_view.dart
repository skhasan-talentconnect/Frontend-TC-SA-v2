import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/preferences/index.dart' show PrefViewModel;

class PrefView extends StatefulWidget {
  const PrefView({required this.isEdit, super.key});
  final bool isEdit;

  @override
  State<PrefView> createState() => _PrefViewState();
}

class _PrefViewState extends State<PrefView> {
  final AppStateProvider appStateProvider = getIt<AppStateProvider>();
  final standardController = TextEditingController();
  final interestController = TextEditingController();
  final schoolTypeController = TextEditingController();
  final shiftController = TextEditingController();
  final boardController = TextEditingController();

  @override
  void initState() {
    standardController.text =
        appStateProvider.userPref?.preferredStandard?.toCapitalise ?? '';
    interestController.text = appStateProvider.userPref?.interests ?? '';
    schoolTypeController.text =
        appStateProvider.userPref?.schoolType?.toCapitalise ?? '';
    shiftController.text = appStateProvider.userPref?.shift?.toCapitalise ?? '';
    boardController.text = appStateProvider.userPref?.boards ?? '';
    super.initState();
  }

  final PrefViewModel prefViewModel = PrefViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          widget.isEdit
              ? SAppBar(
                leading: SIcon(
                  icon: Icons.keyboard_arrow_left,
                  onTap: () {
                    context.pop();
                  },
                ),
                title: 'Edit Preferences',
              )
              : null,

      body: ChangeNotifierProvider.value(
        value: prefViewModel,
        child: Selector<PrefViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder:
              (vmContext, isLoading, __) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : SafeArea(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Column(
                            spacing: 16,
                            children: [
                              if (!widget.isEdit) ...[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    const SizedBox.shrink(),
                                    Text(
                                      'Add your preferences',
                                      style: STextStyles.s20W600,
                                    ),
                                    Text(
                                      'Kindly fill all the details to get your preferred schools.',
                                      style: STextStyles.s16W400,
                                    ),
                                  ],
                                ),
                              ],
                              Form(
                                child: Column(
                                  spacing: 16,
                                  children: [
                                    STextField.dropdown(
                                      controller: boardController,
                                      items: [
                                        'CBSE',
                                        'ICSE',
                                        'CISCE',
                                        'NIOS',
                                        'SSC',
                                        'IGCSE',
                                        'IB',
                                        'KVS',
                                        'JNV',
                                        'DBSE',
                                        'MSBSHSE',
                                        'UPMSP',
                                        'KSEEB',
                                        'WBBSE',
                                        'GSEB',
                                        'RBSE',
                                        'BSEB',
                                        'PSEB',
                                        'BSE',
                                        'SEBA',
                                        'MPBSE',
                                        'STATE',
                                        'OTHER',
                                      ],
                                      label: 'Preferred Board',
                                      hint: 'Select Board',
                                    ),
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
                                      items: [
                                        'Convent',
                                        'Private',
                                        'Government',
                                      ],
                                      label: 'Preferred School Type',
                                      hint: 'Select School Type',
                                    ),
                                    STextField.dropdown(
                                      controller: shiftController,
                                      items: [
                                        'Morning',
                                        'Afternoon',
                                        'Night school',
                                      ],
                                      label: 'Preferred Shifts',
                                      hint: 'Select Shift',
                                    ),
                                  ],
                                ),
                              ),

                              SButton(
                                label: widget.isEdit ? 'Edit' : 'Submit',
                                onPressed: () async {
                                  String boards = boardController.text.trim();
                                  String standard =
                                      standardController.text.trim();
                                  String interest =
                                      interestController.text.trim();
                                  String schoolType =
                                      schoolTypeController.text.trim();
                                  String shifts = shiftController.text.trim();

                                  if (standard.isEmpty ||
                                      interest.isEmpty ||
                                      schoolType.isEmpty ||
                                      shifts.isEmpty ||
                                      boards.isEmpty) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: 'Please fill all the fields',
                                    );
                                  } else {
                                    Failure? failure;
                                    if (widget.isEdit) {
                                      failure = await prefViewModel
                                          .updatePreferences(
                                            boards: boards,
                                            preferredStandard: standard,
                                            interests: interest,
                                            schoolType: schoolType,
                                            shift: shifts,
                                          );
                                    } else {
                                      failure = await prefViewModel
                                          .addPreferences(
                                            boards: boards,
                                            preferredStandard: standard,
                                            interests: interest,
                                            schoolType: schoolType,
                                            shift: shifts,
                                          );
                                    }

                                    Toasts.showSuccessOrFailureToast(
                                      context,
                                      failure: failure,
                                      hideSuccess: true,
                                      successCallback: () {
                                        widget.isEdit
                                            ? context.pop()
                                            : context.pushReplacementNamed(
                                              RouteNames.home,
                                            );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
        ),
      ),
    );
  }
}
