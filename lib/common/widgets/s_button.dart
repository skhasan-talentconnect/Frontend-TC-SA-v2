import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles;

class SButton extends StatelessWidget {
  const SButton({
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.max = false,
    required this.label,
    required this.onPressed,
    super.key,
  }) : _isOutlined = false;

  const SButton.outlined({
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.max = false,
    required this.label,
    required this.onPressed,
    super.key,
  }) : _isOutlined = true;

  final bool _isOutlined;
  final bool max;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
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
                (_isOutlined ? SColor.backgroundColor : SColor.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(max ? 8 : 12),
              side:
                  _isOutlined
                      ? BorderSide(color: SColor.primaryColor)
                      : BorderSide.none,
            ),
          ),
          child: Text(
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
