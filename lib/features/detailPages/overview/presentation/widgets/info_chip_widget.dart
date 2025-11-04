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
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : 12,
        vertical: isSmallScreen ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.shade100.withOpacity(0.5),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.yellow.shade800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: fontSize * 0.8,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
