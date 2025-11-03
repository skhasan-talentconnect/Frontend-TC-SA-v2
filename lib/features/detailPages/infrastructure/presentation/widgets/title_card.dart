import 'package:flutter/material.dart';

class TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const TitledCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white, // 🌟 Light yellow background
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.amber.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.shade200.withOpacity(0.4), // soft yellow shadow
            blurRadius: 12, // 🌟 Increased for higher elevation
            spreadRadius: 2,
            offset: const Offset(0, 6), // Deeper shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Row ---
            Row(
              children: [
                Icon(icon, color: Colors.amber.shade800, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // --- Content ---
            child,
          ],
        ),
      ),
    );
  }
}
