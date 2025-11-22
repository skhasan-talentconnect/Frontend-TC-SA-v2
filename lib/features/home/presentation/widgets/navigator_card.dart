import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart' show colors, SButton, STextStyles;
import 'package:tc_sa/core/common/theme_provider.dart';

class NavigatorCard extends StatelessWidget {
  const NavigatorCard({
    required this.title,
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
                    final colors = context.watch<ThemeProvider>().colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: colors.amberDarkColor),
        color: colors.secTextColor,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: STextStyles.s22W600.copyWith(color: colors.amberColor),
            softWrap: true,
          ),
          const SizedBox(height: 20),
          SButton(
            label: buttonText,
            onPressed: onPressed,
            radius: 12,
            backgroundColor: colors.amberDarkColor,
          ),
        ],
      ),
    );
  }
}
