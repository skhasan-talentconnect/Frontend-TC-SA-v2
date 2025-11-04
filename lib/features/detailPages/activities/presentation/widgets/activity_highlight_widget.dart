import 'package:flutter/material.dart';

class ActivityHighlightWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const ActivityHighlightWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 14.0 : 18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.amber.shade100.withOpacity(0.5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isSmallScreen ? 36.0 : 42.0,
            color: Colors.amber.shade800,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
