import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';

import 'package:tc_sa/features/compare/presentation/widgets/compare_widgets.dart';

class CompareSchools extends StatelessWidget {
  const CompareSchools({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final Map<String, dynamic>? s1 = extra?['school1'] as Map<String, dynamic>?;
    final Map<String, dynamic>? s2 = extra?['school2'] as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SAppBar(
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () => Navigator.of(context).pop(),
        ),
        title: 'School Comparison',
      ),
      body: (s1 == null || s2 == null)
          ? const Center(
              child: Text("No comparison data. Please select schools again."),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompareSchoolsWidgets.headerBlock(),
                  const SizedBox(height: 8),

                  CompareSchoolsWidgets.sectionTitle('Compare Schools'),
                  const SizedBox(height: 4),
                  CompareSchoolsWidgets.sectionSubtitle(
                    'Side-by-side comparison to find your best fit.',
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: CompareSchoolsWidgets.simpleCard(
                          CompareSchoolsWidgets.fmtStr(s1['name']),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CompareSchoolsWidgets.simpleCard(
                          CompareSchoolsWidgets.fmtStr(s2['name']),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  CompareSchoolsWidgets.dataRow(
                    'Board',
                    [
                      CompareSchoolsWidgets.fmtStr(s1['board']),
                      CompareSchoolsWidgets.fmtStr(s2['board']),
                    ],
                  ),
                  CompareSchoolsWidgets.dataRow(
                    'Fee Range',
                    [
                      CompareSchoolsWidgets.fmtStr(s1['feeRange']),
                      CompareSchoolsWidgets.fmtStr(s2['feeRange']),
                    ],
                  ),
                  CompareSchoolsWidgets.dataRow(
                    'School Mode',
                    [
                      CompareSchoolsWidgets.fmtStr(s1['schoolMode']),
                      CompareSchoolsWidgets.fmtStr(s2['schoolMode']),
                    ],
                  ),
                  CompareSchoolsWidgets.dataRow(
                    'Shifts',
                    [
                      CompareSchoolsWidgets.fmtJoin(s1['shifts']),
                      CompareSchoolsWidgets.fmtJoin(s2['shifts']),
                    ],
                  ),
                  CompareSchoolsWidgets.dataRow(
                    'Top Amenities',
                    [
                      CompareSchoolsWidgets.fmtJoin(s1['predefinedAmenities']),
                      CompareSchoolsWidgets.fmtJoin(s2['predefinedAmenities']),
                    ],
                  ),
                  CompareSchoolsWidgets.dataRow(
                    'Activities',
                    [
                      CompareSchoolsWidgets.fmtJoin(s1['activities']),
                      CompareSchoolsWidgets.fmtJoin(s2['activities']),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
