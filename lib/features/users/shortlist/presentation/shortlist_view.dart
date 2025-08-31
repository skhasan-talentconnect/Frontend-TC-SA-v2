import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/widgets/school_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      
       SafeArea(
        child: SingleChildScrollView(
    
        //  padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "Shortlisted Colleges ($shortlistedCollegesCount)",
                style: STextStyles.s26W600.copyWith(color: SColor.primaryColor)
               
              ),
              const SizedBox(height: 8),
               Text(
                "Explore the colleges you've saved for future reference.",
                style: STextStyles.s15W400.copyWith(color: SColor.primaryColor),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),

              ListView.builder(
                itemBuilder: (context, index) {
                  return SchoolCard();
                },
                itemCount: 3,
                shrinkWrap: true,
              ),
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
          style:STextStyles.s18W400.copyWith(color: SColor.secTextColor),
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
