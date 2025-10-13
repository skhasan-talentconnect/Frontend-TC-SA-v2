import 'package:flutter/material.dart';

class TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color color;

  const TitledCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.color = Colors.deepPurpleAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 1),
            color: Colors.black.withOpacity(0.2),
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
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
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
