import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/common/theme_provider.dart';

class QuickHighlights extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final double elevation;

  const QuickHighlights({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.elevation = 2, // Default elevation
  });

  // Helper function to capitalize the first letter
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
        final colors = context.watch<ThemeProvider>().colors;
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(12),
      shadowColor: colors.greyShadowColor, // ✅ grey shadow
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.borderColor, width: 1), // subtle border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28.0, color: colors.amberColor), // consistent tone
            const SizedBox(height: 8),
            Text(
              capitalize(title),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              capitalize(value),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
