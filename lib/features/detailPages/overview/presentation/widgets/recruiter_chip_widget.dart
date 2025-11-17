import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/common/theme_provider.dart';

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
    final colors = context.watch<ThemeProvider>().colors;
    // Using Flutter's built-in Chip widget for a modern look
    return Chip(
      label: Text(label),
      // --- THEME UPDATE ---
      backgroundColor: Colors.white, // Kept blue for this section
      side: BorderSide(color: colors.borderSideColor),
      elevation: 10,
      labelStyle: TextStyle(
        fontSize: isSmallScreen ? 12.0 : 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10.0 : 12.0,
        vertical: isSmallScreen ? 6.0 : 8.0,
      ),
    );
  }
}