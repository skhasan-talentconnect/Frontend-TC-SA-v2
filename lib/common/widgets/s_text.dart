import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class SText extends StatelessWidget {
  const SText({
    this.icon,
    this.iconColor,
    this.iconSize,
    this.title,
    this.titleTextStyles,
    this.options,
    this.spacing,
    super.key,
  });
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final double? spacing;
  final String? title;
  final TextStyle? titleTextStyles;
  final List<Widget>? options;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing ?? 4,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: iconSize ?? 24,
            color: iconColor ?? SColor.secTextColor,
          ),
        ],
        if (title != null) ...[
          Text(title ?? '', style: titleTextStyles ?? STextStyles.s18W600),
        ],
        ...(options ?? []),
      ],
    );
  }
}
