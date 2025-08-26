import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/s_colors.dart';

class SLoadingIndicator extends StatelessWidget {
  const SLoadingIndicator({this.color, this.size, this.thickness, super.key});

  final double? size;
  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 50,
      width: size ?? 50,
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? SColor.primaryColor,
          strokeWidth: thickness,
        ),
      ),
    );
  }
}
