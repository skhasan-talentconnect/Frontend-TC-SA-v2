import 'package:flutter/material.dart';
import 'package:tc_sa/features/predictor/predictor_result_view.dart';

class PredictorPage extends StatelessWidget {
  const PredictorPage({super.key});

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
          //  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
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
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15, color: Colors.black)
                ),
                const SizedBox(height: 23),

                // First dropdown field
                _buildLabel("Select your preferred fee-range"),
                _buildDropdown("Select", (value) {}, ["10000-20000", "30000-40000", "More than 5 Lakh"]),
                STextField.dropdown()
                // Second dropdown field
                _buildLabel("Select your prefered board"),
                _buildDropdown("Select", (value) {}, ["SSC", "HSC", "KSEEB", "CBSE"]),

                // Third dropdown field
                _buildLabel("Select your Preferred Amenities"),
                _buildDropdown("Select", (value) {}, ["PlayGround", "Digital Boards", "Canteen"]),

                const SizedBox(height: 14),
       _buildLabel("Select your Preferred Specialities"),
                _buildDropdown("Select", (value) {}, ["Sports", "Arts", "Technology"]),
               
                
                const SizedBox(height: 24),
                
                // Button section
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchoolResultsPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "Get Schools",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String selectedValue,
    ValueChanged<String?> onChanged,
    List<String> list,
  ) {
   
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: [
        DropdownMenuItem(value: "Select", child: Text("Select")),
        ...list.map((opt) {
          return DropdownMenuItem(value: opt, child: Text(opt));
        }).toList(),
      ],
      onChanged: onChanged,
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}