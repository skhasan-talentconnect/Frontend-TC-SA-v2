import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class ShortlistedSchoolsPage extends StatefulWidget {
  const ShortlistedSchoolsPage({super.key});

  @override
  State<ShortlistedSchoolsPage> createState() =>
      _ShortlistedCollegesPageState();
}

class _ShortlistedCollegesPageState extends State<ShortlistedSchoolsPage> {
  int shortlistedCollegesCount = 0; // Variable to hold the count
  bool hasShortlistedColleges =
      false; // For demonstration, set to false to show empty state

  @override
  void initState() {
    super.initState();
  }

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "Shortlisted Colleges (${dummySchools.length})",
                style: STextStyles.s26W600.copyWith(color: SColor.primaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "Explore the colleges you've saved for future reference.",
                style: STextStyles.s15W400.copyWith(color: SColor.primaryColor),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12),

              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (_, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return SchoolCard(school: dummySchools[index]);
                },
                itemCount: dummySchools.length,
                shrinkWrap: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(Icons.bookmark_border, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          "No Colleges Shortlisted",
          style: STextStyles.s18W400.copyWith(color: SColor.secTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Start exploring colleges and save your favorites to see them here.",
          style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
        ),
      ],
    );
  }
}
