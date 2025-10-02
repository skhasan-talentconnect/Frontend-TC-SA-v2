import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';
import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';


class SpecialNeedsCard extends StatelessWidget {
  // FROM: final Map<String, dynamic> supportData;
  // TO:
  final SpecialNeedsSupportModel supportData;
  
  const SpecialNeedsCard({super.key, required this.supportData});

  @override
  Widget build(BuildContext context) {
    final bool hasStaff = supportData.dedicatedStaff ?? false;
    final double percentage = (supportData.studentsSupportedPercentage ?? 0).toDouble();

    return TitledCard(
      title: 'Special Needs Support',
      icon: Icons.accessible_forward_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: hasStaff ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: hasStaff ? Colors.green.shade200 : Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  hasStaff ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: hasStaff ? Colors.green.shade700 : Colors.red.shade700,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Dedicated Special Educator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hasStaff ? Colors.green.shade800 : Colors.red.shade800,
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
          const Divider(height: 32),
          const Text('Facilities Available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: supportData.facilitiesAvailable.map((item) => Chip(
              label: Text(item),
              backgroundColor: Colors.teal.shade100,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            )).toList(),
          ),
        ],
      ),
    );
  }
}