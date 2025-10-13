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

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // --- START Gradient Background ---
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,        // Start with white
            Colors.blue.shade50, // Transition to a very light blue
          ],
        ),
        // --- END Gradient Background ---
        border: Border.all(color: Colors.blue.shade100, width: 1.5), // Slightly more prominent border
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1), // Adjusted shadow color for gradient
            blurRadius: 6, // Slightly increased blur
            offset: const Offset(0, 3), // Slightly increased offset
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isSmallScreen ? 32.0 : 38.0, // Increased icon size
            color: Colors.blue[700],
          ),
          const SizedBox(height: 10), // Increased spacing
          Text(
            title,
            style: TextStyle(
              fontSize: isSmallScreen ? 14.0 : 16.0, // Increased font size
              color: Colors.black87, // Slightly darker for better readability
              fontWeight: FontWeight.w600, // Slightly bolder
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