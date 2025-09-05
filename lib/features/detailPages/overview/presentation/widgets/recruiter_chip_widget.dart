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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12.0 : 16.0,
        vertical: isSmallScreen ? 8.0 : 10.0,
      ),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey[50],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isSmallScreen ? 12.0 : 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}