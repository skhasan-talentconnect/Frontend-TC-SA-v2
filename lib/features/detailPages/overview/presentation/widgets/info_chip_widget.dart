import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String topText;
  final String bottomText;
  final double fontSize;
  final bool isSmallScreen;

  const InfoChip({
    super.key,
    required this.topText,
    required this.bottomText,
    required this.fontSize,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Increased vertical padding
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.amber.shade200), // Updated color
        borderRadius: BorderRadius.circular(8), // Softer corners
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.amber, // Updated color
            ),
          ),
          const SizedBox(height: 2), // Added spacing
          Text(
            bottomText,
            style: TextStyle(
              fontSize: fontSize * 0.8, // Slightly smaller
              color: Colors.grey.shade600, // Softer text color
            ),
          ),
        ],
      ),
    );
  }
}