import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/common/index.dart';

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
    final colors = context.watch<ThemeProvider>().colors;
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
            color: colors.boxShadowColor,
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
              color: colors.topTextColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: fontSize * 0.8,
              color: colors.bottomTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
