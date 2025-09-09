import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';
import 'package:tc_sa/features/application/forms/presentation/view_models/form_details_view_model.dart';

class FormDetailsView extends StatefulWidget {
  const FormDetailsView({required this.formId, super.key});
  final String formId;

  @override
  State<FormDetailsView> createState() => _FormDetailsViewState();
}

class _FormDetailsViewState extends State<FormDetailsView> {
  FormDetailsViewModel formDetailsViewModel = FormDetailsViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await formDetailsViewModel.getFormById(
        formId: widget.formId,
      );

      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: formDetailsViewModel,
      child: Scaffold(
        appBar: SAppBar(
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () {
              context.pop();
            },
          ),
          title: 'Form Details',
        ),

        body: Selector<FormDetailsViewModel, bool>(
          builder:
              (_, isLoading, __) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 48),
                              color: formDetailsViewModel.form?.status?.color
                                  .withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  formDetailsViewModel.form?.status?.label ??
                                      '',
                                  style: STextStyles.s26W600.copyWith(
                                    color:
                                        formDetailsViewModel
                                            .form
                                            ?.status
                                            ?.color,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Applied to: ',
                                  style: STextStyles.s12W600.copyWith(
                                    color: SColor.secTextColor,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Date: ',
                                      style: STextStyles.s12W400.copyWith(
                                        color: SColor.secTextColor,
                                      ),
                                    ),
                                    Text(
                                      formDetailsViewModel
                                              .form
                                              ?.school
                                              ?.createdAt
                                              ?.toEEEEDDMMMYYYY ??
                                          'Tue, 09th Sept 2025',
                                      style: STextStyles.s12W600.copyWith(
                                        color: SColor.secTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Divider(),
                                Text(
                                  formDetailsViewModel.form?.school?.name ??
                                      '-',
                                  style: STextStyles.s12W600.copyWith(
                                    color: SColor.secTextColor,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'School Mode: ',
                                                style: STextStyles.s12W400
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                              Text(
                                                formDetailsViewModel
                                                        .form
                                                        ?.school
                                                        ?.schoolMode
                                                        ?.toCapitalise ??
                                                    '-',
                                                style: STextStyles.s12W600
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'School Gender: ',
                                            style: STextStyles.s12W400.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                          Text(
                                            formDetailsViewModel
                                                    .form
                                                    ?.school
                                                    ?.genderType
                                                    ?.toCapitalise ??
                                                'Sacred Heart Boys High School',
                                            style: STextStyles.s12W600.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'School Shifts: ',
                                                style: STextStyles.s12W400
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                              Text(
                                                formDetailsViewModel
                                                        .form
                                                        ?.school
                                                        ?.shifts
                                                        ?.join(', ') ??
                                                    '-',
                                                style: STextStyles.s12W600
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'School Location: ',
                                            style: STextStyles.s12W400.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                          Text(
                                            '${formDetailsViewModel.form?.school?.state?.toCapitalise}, ${formDetailsViewModel.form?.school?.city?.toCapitalise}',
                                            style: STextStyles.s12W600.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'By: ',
                              style: STextStyles.s12W600.copyWith(
                                color: SColor.secTextColor,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Divider(),
                                Text(
                                  formDetailsViewModel.form?.user?.name ?? '-',
                                  style: STextStyles.s12W600.copyWith(
                                    color: SColor.secTextColor,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Gender: ',
                                                style: STextStyles.s12W400
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                              Text(
                                                formDetailsViewModel
                                                        .form
                                                        ?.user
                                                        ?.gender
                                                        ?.toCapitalise ??
                                                    '-',
                                                style: STextStyles.s12W600
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date of Birth: ',
                                            style: STextStyles.s12W400.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                          Text(
                                            formDetailsViewModel
                                                    .form
                                                    ?.user
                                                    ?.dateOfBirth
                                                    ?.toDDMMYYYY ??
                                                'Sacred Heart Boys High School',
                                            style: STextStyles.s12W600.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Contact No: ',
                                                style: STextStyles.s12W400
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                              Text(
                                                formDetailsViewModel
                                                        .form
                                                        ?.user
                                                        ?.contactNo ??
                                                    '-',
                                                style: STextStyles.s12W600
                                                    .copyWith(
                                                      color:
                                                          SColor.secTextColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Email: ',
                                            style: STextStyles.s12W400.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                          Text(
                                            formDetailsViewModel
                                                    .form
                                                    ?.user
                                                    ?.email ??
                                                '',
                                            style: STextStyles.s12W600.copyWith(
                                              color: SColor.secTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
          selector: (_, vm) => vm.isLoading,
        ),
      ),
    );
  }
}
