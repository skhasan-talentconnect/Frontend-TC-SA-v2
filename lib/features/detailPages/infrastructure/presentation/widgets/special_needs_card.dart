import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart'
    show TitledCard;

import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';

class SpecialNeedsCard extends StatelessWidget {
  final SpecialNeedsSupportModel supportData;

  const SpecialNeedsCard({super.key, required this.supportData});

  @override
  Widget build(BuildContext context) {
    final bool hasStaff = supportData.dedicatedStaff ?? false;
    final double percentage =
        (supportData.studentsSupportedPercentage ?? 0).toDouble();

    // Amber theme colors
    final Color primaryAmber = Colors.amber.shade700;
    final Color lightAmber = Colors.amber.shade100;
    final Color darkAmber = Colors.amber.shade800;

    return TitledCard(
      title: 'Special Needs Support',
      icon: Icons.accessible_forward_rounded,
      iconColor: primaryAmber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Dedicated staff status box ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasStaff ? Colors.amber.shade200 : Colors.yellow.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.shade100.withOpacity(0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  hasStaff ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: hasStaff ? primaryAmber : Colors.grey.shade500,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Dedicated Special Educator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hasStaff ? darkAmber : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- Students Supported Progress ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Students Supported',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: darkAmber,
                ),
              ),
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

          const SizedBox(height: 20),

          // --- Facilities Section ---
          const Text(
            'Facilities Available',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: supportData.facilitiesAvailable.map((item) {
              return Chip(
                label: Text(item),
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: Colors.yellow.shade200.withOpacity(0.3),
                ),
                elevation: 4,
                shadowColor: Colors.amber.shade100.withOpacity(0.4),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0D47A1), // dark blue text
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
