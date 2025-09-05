import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/navigation/route_name.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';

class SchoolResultsPage extends StatefulWidget {
  const SchoolResultsPage({super.key, required this.predictedSchools});
  final List<SchoolModel> predictedSchools;

  @override
  State<SchoolResultsPage> createState() => _SchoolResultPageState();
}

class _SchoolResultPageState extends State<SchoolResultsPage> {
  @override
  Widget build(BuildContext context) {
    final predictedSchools = widget.predictedSchools;

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                "Your personalized School recommendations based on your preferences.",
                style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
              ),
              const SizedBox(height: 24),

              // Show results
              if (predictedSchools.isEmpty)
                Center(
                  child: Text(
                    "No schools found matching your criteria",
                    style: STextStyles.s16W400.copyWith(color: SColor.secTextColor),
                  ),
                )
              else
                // School cards list
                ListView.separated(
                  itemBuilder: (context, index) {
                    final school = predictedSchools[index];
                    return SchoolCard(
                      school: SchoolCardModel(
                        schoolId: school.id,
                   
                        name: school.name ?? 'School Name',
                        feeRange: school.feeRange ?? 'Not specified',
                        location: '${school.city ?? ''}, ${school.state ?? ''}',
                        board: school.board ?? 'Not specified',
                        genderType: school.genderType ?? 'Not specified',
                        shifts: school.shifts ?? [],
                        schoolMode: school.schoolMode ?? 'Not specified',
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: predictedSchools.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              
              const SizedBox(height: 28),

              // Edit Preferences button
              Center(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop(); // Go back to predictor page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
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