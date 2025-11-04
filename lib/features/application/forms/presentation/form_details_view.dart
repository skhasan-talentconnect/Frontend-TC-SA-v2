import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';
import 'package:tc_sa/features/application/forms/presentation/dateTimeExtension.dart';
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
            onTap: () => context.pop(),
          ),
          title: 'Form Details',
        ),
        body: Selector<FormDetailsViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder: (_, isLoading, __) {
            if (isLoading) return const Center(child: SLoadingIndicator());

            final form = formDetailsViewModel.form;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟩 Status Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    color: form?.status?.color.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        form?.status?.label ?? '',
                        style: STextStyles.s26W600.copyWith(
                          color: form?.status?.color,
                          
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 🟨 Applied To + Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Applied to:',
                        style: STextStyles.s12W600
                            .copyWith(color: SColor.secTextColor),
                      ),
                      Expanded(
                        child: Text(
                          form?.school?.name ?? '-',
                          textAlign: TextAlign.end,
                          style: STextStyles.s12W600
                              .copyWith(color: SColor.secTextColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date:',
                        style: STextStyles.s12W400
                            .copyWith(color: SColor.secTextColor),
                      ),
                      Text(
                        form?.createdAt != null
                            ? form!.createdAt!.toEEEEDDMMMYYYY
                            : '-',
                        style: STextStyles.s12W600
                            .copyWith(color: SColor.secTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),

                  // 🏫 School Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildLabelValue(
                          label: 'School Mode:',
                          value:
                              form?.school?.schoolMode?.toCapitalise ?? '-',
                        ),
                      ),
                      Expanded(
                        child: _buildLabelValue(
                          label: 'Gender Type:',
                          value:
                              form?.school?.genderType?.toCapitalise ?? '-',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildLabelValue(
                          label: 'School Shifts:',
                          value: form?.school?.shifts?.join(', ') ?? '-',
                        ),
                      ),
                      Expanded(
                        child: _buildLabelValue(
                          label: 'School Location:',
                          value:
                              '${form?.school?.state?.toCapitalise ?? ''}, ${form?.school?.city?.toCapitalise ?? ''}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
const Divider(),
                  // 👤 User Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By:',
                        style: STextStyles.s12W600
                            .copyWith(color: SColor.secTextColor),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          form?.user?.name ?? '-',
                       
                          style: STextStyles.s12W600
                              .copyWith(color: SColor.secTextColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  const SizedBox(height: 8),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildLabelValue(
                          label: 'Contact No:',
                          value: form?.user?.contactNo ?? '-',
                        ),
                      ),
                      Expanded(
                        child: _buildLabelValue(
                          label: 'Email:',
                          value: form?.user?.email ?? '-',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 🟢 Status Details Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Details',
                          style: STextStyles.s14W400
                              .copyWith(color: SColor.primaryColor),
                        ),
                        const Divider(height: 16),
                        _buildRowText(
                          'Current Status:',
                          form?.status?.label ?? '-',
                          color: form?.status?.color ?? SColor.secTextColor,
                        ),
                        const SizedBox(height: 8),
                        _buildRowText(
                          'Created On:',
                          form?.createdAt?.toEEEEDDMMMYYYY ?? '-',
                        ),
                        const SizedBox(height: 8),
                        _buildRowText(
                          'Last Updated:',
                          form?.updatedAt?.toEEEEDDMMMYYYY ?? '-',
                        ),

                        // 🗒️ Interview Note (if present)
                        if ((form?.interviewNote ?? '').isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            'Interview Note:',
                            style: STextStyles.s12W400
                                .copyWith(color: SColor.secTextColor),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: SColor.backgroundColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              form!.interviewNote!,
                              style: STextStyles.s12W600
                                  .copyWith(color: SColor.secTextColor),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 🔹 Helper Widgets
  Widget _buildLabelValue({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                STextStyles.s12W400.copyWith(color: SColor.secTextColor)),
        Text(value,
            style:
                STextStyles.s12W600.copyWith(color: SColor.secTextColor)),
      ],
    );
  }

  Widget _buildRowText(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                STextStyles.s12W400.copyWith(color: SColor.secTextColor)),
        Text(
          value,
          style: STextStyles.s12W600.copyWith(color: color ?? SColor.secTextColor),
        ),
      ],
    );
  }
}

                                // Container(
                                //   width: double.infinity,
                                //   padding: const EdgeInsets.all(16),
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(12),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.black12,
                                //         blurRadius: 4,
                                //         offset: Offset(0, 2),
                                //       ),
                                //     ],
                                //   ),
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     spacing: 8,
                                //     children: [
                                //       Text(
                                //         'Applied By: ',
                                //         style: STextStyles.s12W600.copyWith(
                                //           color: SColor.secTextColor,
                                //         ),
                                //       ),
                                //       Divider(),
                                //       Text(
                                //         formDetailsViewModel.form?.user?.name ??
                                //             '-',
                                //         style: STextStyles.s12W600.copyWith(
                                //           color: SColor.secTextColor,
                                //         ),
                                //       ),
                                //       Row(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Expanded(
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: [
                                //                     Text(
                                //                       'Gender: ',
                                //                       style: STextStyles.s12W400
                                //                           .copyWith(
                                //                             color:
                                //                                 SColor
                                //                                     .secTextColor,
                                //                           ),
                                //                     ),
                                //                     Text(
                                //                       formDetailsViewModel
                                //                               .form
                                //                               ?.user
                                //                               ?.gender
                                //                               ?.toCapitalise ??
                                //                           '-',
                                //                       style: STextStyles.s12W600
                                //                           .copyWith(
                                //                             color:
                                //                                 SColor
                                //                                     .secTextColor,
                                //                           ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           Expanded(
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Text(
                                //                   'Date of Birth: ',
                                //                   style: STextStyles.s12W400
                                //                       .copyWith(
                                //                         color:
                                //                             SColor.secTextColor,
                                //                       ),
                                //                 ),
                                //                 Text(
                                //                   formDetailsViewModel
                                //                           .form
                                //                           ?.user
                                //                           ?.dateOfBirth ??
                                //                       'Sacred Heart Boys High School',
                                //                   style: STextStyles.s12W600
                                //                       .copyWith(
                                //                         color:
                                //                             SColor.secTextColor,
                                //                       ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       Row(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Expanded(
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: [
                                //                     Text(
                                //                       'Contact No: ',
                                //                       style: STextStyles.s12W400
                                //                           .copyWith(
                                //                             color:
                                //                                 SColor
                                //                                     .secTextColor,
                                //                           ),
                                //                     ),
                                //                     Text(
                                //                       formDetailsViewModel
                                //                               .form
                                //                               ?.user
                                //                               ?.contactNo ??
                                //                           '-',
                                //                       style: STextStyles.s12W600
                                //                           .copyWith(
                                //                             color:
                                //                                 SColor
                                //                                     .secTextColor,
                                //                           ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           Expanded(
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Text(
                                //                   'Email: ',
                                //                   style: STextStyles.s12W400
                                //                       .copyWith(
                                //                         color:
                                //                             SColor.secTextColor,
                                //                       ),
                                //                 ),
                                //                 Text(
                                //                   formDetailsViewModel
                                //                           .form
                                //                           ?.user
                                //                           ?.email ??
                                //                       '',
                                //                   style: STextStyles.s12W600
                                //                       .copyWith(
                                //                         color:
                                //                             SColor.secTextColor,
                                //                       ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                //
                                // const SizedBox(height: 24),
                                // Container(
                                //   width: double.infinity,
                                //   padding: const EdgeInsets.all(16),
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(12),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.black12,
                                //         blurRadius: 4,
                                //         offset: Offset(0, 2),
                                //       ),
                                //     ],
                                //   ),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         'Status Details',
                                //         style: STextStyles.s14W400.copyWith(
                                //           color: SColor.primaryColor,
                                //         ),
                                //       ),
                                //       const Divider(height: 16),
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'Current Status:',
                                //             style: STextStyles.s12W400.copyWith(
                                //               color: SColor.secTextColor,
                                //             ),
                                //           ),
                                //           Text(
                                //             formDetailsViewModel
                                //                     .form
                                //                     ?.status
                                //                     ?.label ??
                                //                 '-',
                                //             style: STextStyles.s12W600.copyWith(
                                //               color:
                                //                   formDetailsViewModel
                                //                       .form
                                //                       ?.status
                                //                       ?.color ??
                                //                   SColor.secTextColor,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       const SizedBox(height: 8),
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'Created On:',
                                //             style: STextStyles.s12W400.copyWith(
                                //               color: SColor.secTextColor,
                                //             ),
                                //           ),
                                //           Text(
                                //             formDetailsViewModel
                                //                     .form
                                //                     ?.createdAt
                                //                     ?.toEEEEDDMMMYYYY ??
                                //                 '-',
                                //             style: STextStyles.s12W600.copyWith(
                                //               color: SColor.secTextColor,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       const SizedBox(height: 8),
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'Last Updated:',
                                //             style: STextStyles.s12W400.copyWith(
                                //               color: SColor.secTextColor,
                                //             ),
                                //           ),
                                //           Text(
                                //             formDetailsViewModel
                                //                     .form
                                //                     ?.updatedAt
                                //                     ?.toEEEEDDMMMYYYY ??
                                //                 '-',
                                //             style: STextStyles.s12W600.copyWith(
                                //               color: SColor.secTextColor,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       const SizedBox(height: 8),
                                //
                                //       // 🗒️ Optional Note
                                //       if ((formDetailsViewModel
                                //                   .form
                                //                   ?.interviewNote ??
                                //               '')
                                //           .isNotEmpty) ...[
                                //         const SizedBox(height: 12),
                                //         Text(
                                //           'Interview Note:',
                                //           style: STextStyles.s12W400.copyWith(
                                //             color: SColor.secTextColor,
                                //           ),
                                //         ),
                                //         const SizedBox(height: 4),
                                //         Container(
                                //           width: double.infinity,
                                //           padding: const EdgeInsets.all(10),
                                //           decoration: BoxDecoration(
                                //             color: SColor.backgroundColor
                                //                 .withOpacity(0.3),
                                //             borderRadius: BorderRadius.circular(
                                //               8,
                                //             ),
                                //           ),
                                //           child: Text(
                                //             formDetailsViewModel
                                //                 .form!
                                //                 .interviewNote!,
                                //             style: STextStyles.s12W600.copyWith(
                                //               color: SColor.secTextColor,
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ],
                                //   ),
                                // ),