import 'package:flutter/material.dart';

class TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor; // Changed 'color' to 'iconColor' for clarity

  const TitledCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = Colors.black, // Default to black
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Use a subtle border
        border: Border.all(color: Colors.grey.shade200, width: 1),
        // Use a softer, more modern shadow
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Use a slightly off-black color
                      ),
                ),
              ],
            ),
       
            child,
          ],
        ),
      ),
    );
  }
}