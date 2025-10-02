import 'package:flutter/material.dart';

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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            if (items.isEmpty)
              const Text('No data available')
            else
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: items
                    .map((item) => Chip(
                          label: Text(item),
                          backgroundColor: chipColor,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w500),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}