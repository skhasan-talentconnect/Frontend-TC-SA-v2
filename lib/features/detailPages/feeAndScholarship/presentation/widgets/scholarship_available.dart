import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';

import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';

class ScholarshipDiversityCard extends StatelessWidget {
  final ScholarshipDiversityModel diversityData;

  const ScholarshipDiversityCard({super.key, required this.diversityData});

  @override
  Widget build(BuildContext context) {
    final double percentage = (diversityData.studentsCoveredPercentage ?? 0).toDouble();

    return TitledCard(
      title: 'Scholarship Diversity',
      icon: Icons.school_outlined,
      // --- THEME UPDATE: Set icon color ---
      iconColor: Colors.amber.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Students Covered', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              // --- THEME UPDATE: Set text color ---
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amber.shade800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 12,
              // --- THEME UPDATE: Progress bar colors ---
              backgroundColor: Colors.amber.shade100,
              color: Colors.amber.shade700,
            ),
          ),
          // --- UI POLISH: Added a divider ---
         SizedBox(height: 20,),
          const Text('Types Offered', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: diversityData.types.map((item) => Chip(
              label: Text(item),
              // --- THEME UPDATE: Chip colors ---
              backgroundColor: Colors.amber.shade50,
              side: BorderSide(color: Colors.amber.shade200),
              labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
            )).toList(),
            
          ),
        ],
      ),
    );
  }
}