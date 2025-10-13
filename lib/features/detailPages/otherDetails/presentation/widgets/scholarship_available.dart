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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Students Covered', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 12,
              backgroundColor: Colors.deepPurple.shade100,
              color: Colors.deepPurple,
            ),
          ),
        
          const Text('Types Offered', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: diversityData.types.map((item) => Chip(
              label: Text(item),
              backgroundColor: Colors.orange.shade100,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            )).toList(),
          ),
        ],
      ),
    );
  }
}