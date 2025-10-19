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

    return TitledCard(
      title: 'Special Needs Support',
      icon: Icons.accessible_forward_rounded,
      // --- 1. THEME UPDATE: Set icon color ---
      iconColor: Colors.amber.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              // --- 2. THEME UPDATE: Use green for positive, grey for neutral ---
              color: hasStaff ? Colors.amber : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: hasStaff ? Colors.green.shade200 : Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(
                  hasStaff ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: hasStaff ? Colors.amber : Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Dedicated Special Educator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hasStaff ? Colors.amber : Colors.white,
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
              // --- 3. THEME UPDATE: Set text color ---
              Text('${percentage.toStringAsFixed(0)}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amber.shade800)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 12,
              // --- 4. THEME UPDATE: Progress bar colors ---
              backgroundColor: Colors.amber.shade100,
              color: Colors.amber.shade700,
            ),
          ),
          
        SizedBox(height :20),

          const Text('Facilities Available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: supportData.facilitiesAvailable.map((item) => Chip(
              label: Text(item),
              // --- 5. THEME UPDATE: Chip colors ---
              backgroundColor: Colors.amber.shade50,
              side: BorderSide(color: Colors.amber.shade200),
              labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.amber.shade900),
            )).toList(),
          ),
        ],
      ),
    );
  }
}