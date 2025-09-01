import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';

class SchoolResultsPage extends StatefulWidget {
  const SchoolResultsPage({super.key});

  @override
  State<SchoolResultsPage> createState() => _SchoolResultPageState();
}

class _SchoolResultPageState extends State<SchoolResultsPage> {
  final dummySchools = <SchoolCardModel>[
    SchoolCardModel(
      schoolId: "1",
      ratings: 4,
      name: "Green Valley High School",
      feeRange: "25000 - 50",
      location: "Mumbai, Maharashtra",
      board: "CBSE",
      genderType: "co-ed",
      shifts: ["morning"],
      schoolMode: "private",
    ),
    SchoolCardModel(
      schoolId: "2",
      ratings: 5,
      name: "Sunrise International School",
      feeRange: "1 Lakh - 2 Lakh",
      location: "Delhi, Delhi",
      board: "IB",
      genderType: "co-ed",
      shifts: ["morning", "afternoon"],
      schoolMode: "convent",
    ),
    SchoolCardModel(
      schoolId: "3",
      ratings: 3,
      name: "St. Mary’s Convent",
      feeRange: "10000 - 25000",
      location: "Pune, Maharashtra",
      board: "ICSE",
      genderType: "girl",
      shifts: ["morning"],
      schoolMode: "convent",
    ),
    SchoolCardModel(
      schoolId: "4",
      ratings: 2,
      name: "Govt. Boys High School",
      feeRange: "1000 - 10000",
      location: "Lucknow, Uttar Pradesh",
      board: "STATE",
      genderType: "boy",
      shifts: ["afternoon"],
      schoolMode: "government",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: 'Predicted Schools',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Predict Your Rank. Find Your School.",
                style: STextStyles.s14W400.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 6),
              Text(
                "School Predictor",
                style: STextStyles.s28W800.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                "Your personalized School recommendations based on your score.",
                style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
              ),
              const SizedBox(height: 24),

              // School cards list
              ListView.separated(
                itemBuilder: (context, index) {
                  return SchoolCard(school: dummySchools[index]);
                },
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemCount: dummySchools.length,
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
