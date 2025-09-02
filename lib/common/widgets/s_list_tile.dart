import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';

class SListTile extends StatelessWidget {
  const SListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.label,
    this.subLabel,
    this.trailing,
    this.onTap,
    this.path,
    this.border,
    this.borderWidth,
    super.key,
  }) : _isNavigator = false;

  const SListTile.navigator({
    this.leading,
    this.title,
    this.subtitle,
    this.label,
    this.subLabel,
    this.trailing,
    this.onTap,
    this.border,
    this.borderWidth,
    required this.path,
    super.key,
  }) : _isNavigator = true;

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final String? label;
  final String? subLabel;
  final String? path;
  final BoxBorder? border;
  final double? borderWidth;
  final VoidCallback? onTap;
  final bool _isNavigator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            border ??
            Border(
              bottom: BorderSide(
                color: SColor.secTextColor,
                width: borderWidth ?? 0.5,
              ),
            ),
      ),
      child: ListTile(
        tileColor: SColor.backgroundColor,
        leading: leading,
        title:
            label != null
                ? Text(label ?? '', style: STextStyles.s16W600)
                : title,
        subtitle:
            subLabel == null
                ? subtitle
                : Text(subLabel ?? '', style: STextStyles.s16W400),
        trailing: trailing,
        onTap:
            _isNavigator
                ? () {
                  if (path != null && (path ?? "").isNotEmpty) {
                    context.pushNamed(path ?? '');
                  }
                }
                : onTap,
      ),
    );
  }
}
