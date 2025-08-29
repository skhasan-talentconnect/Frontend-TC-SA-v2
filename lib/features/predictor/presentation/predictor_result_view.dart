import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/theme/styles.dart';

class SchoolResultsPage extends StatefulWidget {
  const SchoolResultsPage({super.key});

  @override
  State<SchoolResultsPage> createState() => _SchoolResultPageState();
}

class _SchoolResultPageState extends State<SchoolResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Predict Your Rank. Find Your College.",
                style: STextStyles.s14W400.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 6),
              Text(
                "College Predictor",
                style: STextStyles.s28W800.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                "Your personalized college recommendations based on your score.",
                style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
              ),
              const SizedBox(height: 24),
              
              // School cards list
              ListView.separated(
                  itemBuilder: (context, index) {
                    return SchoolCard();
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              const SizedBox(height: 28),
              
              // Edit Preferences button at the bottom
              Center(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle edit preferences action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Edit Preferences",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}