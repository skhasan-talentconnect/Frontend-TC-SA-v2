import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SIcon extends StatelessWidget {
  const SIcon({
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.image,
    this.padding,
    this.path,
    super.key,
  }) : _isNavigator = false;

  const SIcon.navigator({
    required this.path,
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.image,
    this.padding,
    super.key,
  }) : _isNavigator = true;

  final bool _isNavigator;
  final String? path;
  final VoidCallback? onTap;
  final IconData? icon;
  final Widget? image;
  final double? size;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          _isNavigator
              ? () {
                context.pushNamed(path ?? '');
              }
              : onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: image ?? Icon(icon, size: size, color: color),
      ),
    );
  }
}
