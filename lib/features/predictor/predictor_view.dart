import 'package:flutter/material.dart';
import 'package:tc_sa/features/predictor/predictor_result_view.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles, STextField, SButton;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              const Text(
                "Your Options. Your School.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "School Predictor",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Discover the schools that matches the exact requirement for your kid.",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black)
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchoolResultsPage()
                      )
                    );
                  },
                ),
              ),
              
              // Disclaimer section
              const SizedBox(height: 12),
              Text(
                "Predictions are based on available data and may not reflect actual outcomes",
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF757575),
                  height: 1,
                ),
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
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}