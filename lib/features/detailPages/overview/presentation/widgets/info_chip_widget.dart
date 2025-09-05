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
        horizontal: isSmallScreen ? 5.0 : 8.0,
        vertical: isSmallScreen ? 4.0 : 6.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: fontSize * 0.85,
            ),
          ),
        ],
      ),
    );
  }
}