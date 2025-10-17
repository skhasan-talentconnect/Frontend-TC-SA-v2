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
      padding: EdgeInsets.all(isSmallScreen ? 14.0 : 18.0), // Adjusted padding
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(12), // Softer corners
        border: Border.all(color: Colors.amber.shade300, width: 1), // Light yellow border
        boxShadow: [
          BoxShadow(
            color: Colors.amber.shade100.withOpacity(0.5), // Subtle yellow shadow
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isSmallScreen ? 36.0 : 42.0, // Larger icon
            color: Colors.amber.shade800, // Darker yellow icon
          ),
          const SizedBox(height: 12), // Increased spacing
          Text(
            title,
            style: textTheme.bodyLarge?.copyWith( // Use bodyLarge for slightly bigger text
              color: Colors.black87,
              fontWeight: FontWeight.w500, // Medium weight
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