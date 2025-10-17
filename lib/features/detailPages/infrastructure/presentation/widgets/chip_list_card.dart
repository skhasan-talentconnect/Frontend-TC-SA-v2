import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';

class ChipListCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final Color chipColor;
  final Color iconColor;

  const ChipListCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.chipColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // Use the TitledCard as the base
    return TitledCard(
      title: title,
      icon: icon,
      iconColor: iconColor,
      child: (items.isEmpty)
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('No data available'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: items
                    .map(
                      (item) => Chip(
                        label: Text(item),
                        backgroundColor: chipColor,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        // Add a subtle border to the chip
                        side: BorderSide(color: iconColor.withOpacity(0.3)),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}