import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart'
    show SColor, STextStyles, STextField, SButton, SAppBar, SIcon;
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/predictor/presentation/view_models/predictor_view_model.dart';

class PredictorPage extends StatefulWidget {
  const PredictorPage({super.key});

  @override
  State<PredictorPage> createState() => _PredictorPageState();
}

class _PredictorPageState extends State<PredictorPage> {
  // Controllers for each dropdown
  final TextEditingController _feeRangeController = TextEditingController();
  final TextEditingController _boardController = TextEditingController();
  final TextEditingController _schoolModeController = TextEditingController();
  final TextEditingController _genderTypeController = TextEditingController();

  final viewModel = PrefViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: SAppBar(
          title: 'Predict Schools',
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Options. Your School.",
                  style: STextStyles.s18W600.copyWith(
                    color: SColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "School Predictor",
                  style: STextStyles.s30W900.copyWith(
                    color: SColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Discover the schools that matches the exact requirement for your kid.",
                  style: STextStyles.s15W400.copyWith(
                    color: SColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 23),

                // Fee Range dropdown
                _buildLabel("Select your preferred fee-range"),
                const SizedBox(height: 8),
                STextField.dropdown(
                  controller: _feeRangeController,
                  items: const [
                    "1000 - 10000",
                    "10000 - 25000",
                    "25000 - 50000",
                    "50000 - 75000",
                    "75000 - 100000",
                    "1 Lakh - 2 Lakh",
                    "2 Lakh - 3 Lakh",
                    "3 Lakh - 4 Lakh",
                    "4 Lakh - 5 Lakh",
                    "More than 5 Lakh",
                  ],
                  label: "Fee Range",
                  hint: "Select fee range",
                ),

                // Board dropdown
                const SizedBox(height: 16),
                _buildLabel("Select your prefered board"),
                const SizedBox(height: 8),
                STextField.dropdown(
                  controller: _boardController,
                  items: const [
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
                  label: "Education Board",
                  hint: "Select board",
                ),

                // School Mode dropdown
                const SizedBox(height: 16),
                _buildLabel("Select your Preferred SchoolMode"),
                const SizedBox(height: 8),
                STextField.dropdown(
                  controller: _schoolModeController,
                  items: const ['convent', 'private', 'government'],
                  label: "Modes",
                  hint: "Select Modes",
                ),

                // Gender Type dropdown
                const SizedBox(height: 16),
                _buildLabel("Select your Preferred Gender Type for School"),
                const SizedBox(height: 8),
                STextField.dropdown(
                  controller: _genderTypeController,
                  items: const ['boy', 'girl', 'co-ed'],
                  label: "Genders",
                  hint: "Select Gender",
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 24),

                // Button section
                Center(
                  child: SButton(
                    max: true,
                    label: "Get Schools",
                    onPressed: () async {
                      final filters = {
                        if (_feeRangeController.text.isNotEmpty)
                          'feeRange': _feeRangeController.text,
                        if (_boardController.text.isNotEmpty)
                          'board': _boardController.text,
                        if (_schoolModeController.text.isNotEmpty)
                          'schoolMode': _schoolModeController.text,
                        if (_genderTypeController.text.isNotEmpty)
                          'genderType': _genderTypeController.text,
                      };

                      print('Sending filters to backend: $filters');

                      final failure = await viewModel.predictSchools(
                        filters: filters,
                      );

                      if (failure == null) {
                        print(
                          'Received ${viewModel.predictedSchools.length} schools from backend',
                        );
                        if (viewModel.predictedSchools.isNotEmpty) {
                          print(
                            'First school: ${viewModel.predictedSchools.first.toJson()}',
                          );
                        }

                        // Pass the predicted schools as extra
                        context.pushNamed(
                          RouteNames.predictorResult,
                          extra: viewModel.predictedSchools,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${failure.message}')),
                        );
                      }
                    },
                  ),
                ),

                // Disclaimer section
                const SizedBox(height: 12),
                Text(
                  "Predictions are based on available data and may not reflect actual outcomes",
                  style: STextStyles.s10W400.copyWith(
                    color: SColor.terTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: STextStyles.s16W400.copyWith(color: SColor.primaryColor),
    );
  }
}
