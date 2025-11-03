import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart' show TitledCard;

import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';

class SpecialNeedsCard extends StatelessWidget {
 final SpecialNeedsSupportModel supportData;

const SpecialNeedsCard({super.key, required this.supportData});

 @override
  Widget build(BuildContext context) {
 final bool hasStaff = supportData.dedicatedStaff ?? false;
 final double percentage = (supportData.studentsSupportedPercentage ?? 0).toDouble();

 // Define a consistent amber shade for key elements
 final Color primaryAmber = Colors.amber.shade700;
 final Color lightAmber = Colors.amber.shade100;
 final Color darkAmber = Colors.amber.shade800;
 final Color chipBackground = Colors.amber.shade50;
final Color chipBorder = Colors.amber.shade200;
final Color chipText = Colors.amber.shade900;


return TitledCard(
 title: 'Special Needs Support',
icon: Icons.accessible_forward_rounded,
// 1. Set icon color to primary amber
 iconColor: primaryAmber,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
decoration: BoxDecoration(
color: Colors.white, // Always white background for simplicity and white/amber theme
 borderRadius: BorderRadius.circular(8),
// Border should be a subtle grey when neutral, and a light amber when positive
 border: Border.all(color: hasStaff ? chipBorder : Colors.grey.shade300),
 ),
 child: Row(
 children: [
Icon(
 hasStaff ? Icons.check_circle_rounded : Icons.cancel_rounded,
// Icon color is primary amber if positive, subtle grey if neutral
 color: hasStaff ? primaryAmber : Colors.grey.shade500,
 ),
const SizedBox(width: 10),
 Expanded(
child: Text(
 'Dedicated Special Educator',
style: TextStyle(
fontWeight: FontWeight.bold,
// Text color is dark grey, or primary amber if positive
color: hasStaff ? darkAmber : Colors.grey.shade700,
),
 ),
),
],
 ),
),
 const SizedBox(height: 20),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
 children: [
const Text('Students Supported', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
 // 3. Set text color to a darker amber shade for contrast
Text('${percentage.toStringAsFixed(0)}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: darkAmber)),
 ],
),
 const SizedBox(height: 8),
ClipRRect(
borderRadius: BorderRadius.circular(10),
child: LinearProgressIndicator(
 value: percentage / 100,
minHeight: 12,
backgroundColor: lightAmber,
 color: primaryAmber,
 ),
),
 const SizedBox(height :20),

 const Text('Facilities Available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
 const SizedBox(height: 8),
 Wrap(
spacing: 8.0,
runSpacing: 4.0,
 children: supportData.facilitiesAvailable.map((item) => Chip(
 label: Text(item),
 backgroundColor: chipBackground,
side: BorderSide(color: chipBorder),
labelStyle: TextStyle(fontWeight: FontWeight.w500, color: chipText),
)).toList(),
),
 ],
),
 );
}
}