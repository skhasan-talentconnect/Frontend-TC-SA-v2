import 'package:flutter/material.dart';

class RecruiterChip extends StatelessWidget {
  final String label;
  final bool isSmallScreen;

  const RecruiterChip({
    super.key,
    required this.label,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    // Using Flutter's built-in Chip widget for a modern look
    return Chip(
      label: Text(label),
      // --- THEME UPDATE ---
      backgroundColor: Colors.white.withOpacity(0.1), // Kept blue for this section
      side: BorderSide(color: Colors.amber.withOpacity(0.3)),
      labelStyle: TextStyle(
        fontSize: isSmallScreen ? 12.0 : 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.blue.shade900,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10.0 : 12.0,
        vertical: isSmallScreen ? 6.0 : 8.0,
      ),
    );
  }
}