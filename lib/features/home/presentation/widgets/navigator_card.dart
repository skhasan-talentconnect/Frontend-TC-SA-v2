import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show SColor, SButton, STextStyles;

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: SColor.borderColor)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: STextStyles.s22W600.copyWith(color: SColor.secTextColor),
            softWrap: true,
          ),
          const SizedBox(height: 20),
          SButton(label: buttonText, onPressed: onPressed, radius: 0),
        ],
      ),
    );
  }
}
