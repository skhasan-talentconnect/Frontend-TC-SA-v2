import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart'
    show SchoolCard, SchoolCardModel, SAppBar, SIcon;

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({super.key});

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
      appBar: SAppBar(
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () => Navigator.of(context).pop(),
        ),
        title: "Result Schools",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // School cards list
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return SchoolCard(school: dummySchools[index]);
                },
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemCount: dummySchools.length,
                shrinkWrap: true,
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
