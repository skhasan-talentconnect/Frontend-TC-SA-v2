import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart'
    show SColor, STextStyles, STextField, SButton, SAppBar, SIcon;
import 'package:tc_sa/core/index.dart';

class PredictorPage extends StatefulWidget {
  const PredictorPage({super.key});

  @override
  State<PredictorPage> createState() => _PredictorPageState();
}

class _PredictorPageState extends State<PredictorPage> {
  // Controllers for each dropdown
  final TextEditingController _feeRangeController = TextEditingController();
  final TextEditingController _boardController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  final TextEditingController _specialitiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),ontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Text(
                "Your Options. Your School.",
                style: STextStyles.s18W600.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                "School Predictor",
                style: STextStyles.s30W900.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 12),
              Text(
                "Discover the schools that matches the exact requirement for your kid.",
                style: STextStyles.s15W400.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 23),

              // First dropdown field
              _buildLabel("Select your preferred fee-range"),
              const SizedBox(height: 8),
              STextField.dropdown(
                controller: _feeRangeController,
                items: const ["10000-20000", "30000-40000", "More than 5 Lakh"],
                label: "Fee Range",
                hint: "Select fee range",
              ),

              // Second dropdown field
              const SizedBox(height: 16),
              _buildLabel("Select your prefered board"),
              const SizedBox(height: 8),
              STextField.dropdown(
                controller: _boardController,
                items: const ["SSC", "HSC", "KSEEB", "CBSE"],
                label: "Education Board",
                hint: "Select board",
              ),

              // Third dropdown field
              const SizedBox(height: 16),
              _buildLabel("Select your Preferred Amenities"),
              const SizedBox(height: 8),
              STextField.dropdown(
                controller: _amenitiesController,
                items: const ["PlayGround", "Digital Boards", "Canteen"],
                label: "Amenities",
                hint: "Select amenities",
              ),

              // Fourth dropdown field
              const SizedBox(height: 16),
              _buildLabel("Select your Preferred Specialities"),
              const SizedBox(height: 8),
              STextField.dropdown(
                controller: _specialitiesController,
                items: const ["Sports", "Arts", "Technology"],
                label: "Specialities",
                hint: "Select specialities",
              ),

              const SizedBox(height: 24),

              // Button section - Using SButton instead of ElevatedButton
              Center(
                child: SButton(
                  max: true,
                  label: "Get Schools",
                  onPressed: () {
                    context.pushNamed(RouteNames.predictorResult);
                  },
                ),
              ),

              // Disclaimer section
              const SizedBox(height: 12),
              Text(
                "Predictions are based on available data and may not reflect actual outcomes",
                style: STextStyles.s10W400.copyWith(color: SColor.terTextColor),
                textAlign: TextAlign.center,
              ),
            ],
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
