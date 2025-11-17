import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles;
import 'package:tc_sa/core/common/index.dart';

class SButton extends StatelessWidget {
  const SButton({
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.max = false,
    this.text,
    this.radius,
    required this.label,
    required this.onPressed,
    super.key,
  }) : _isOutlined = false;

  const SButton.outlined({
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.max = false,
    this.text,
    this.radius,
    required this.label,
    required this.onPressed,
    super.key,
  }) : _isOutlined = true;

  final bool _isOutlined;
  final bool max;
  final double? radius;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final String label;
  final Widget? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ThemeProvider>().colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          max ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            backgroundColor:
                backgroundColor ??
                (_isOutlined ? colors.backgroundColor : colors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(max ? 8 : (radius ?? 12)),
              side:
                  _isOutlined
                      ? BorderSide(color: colors.primaryColor)
                      : BorderSide.none,
            ),
          ),
          child:
              text ??
              Text(
                label,
                style: STextStyles.s18W600.copyWith(
                  color: _isOutlined ? SColor.primaryColor : SColor.textColor,
                  letterSpacing: 2,
                ),
              ),
        ),
      ],
    );
  }
}
