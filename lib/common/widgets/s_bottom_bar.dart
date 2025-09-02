import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tc_sa/common/index.dart'
    show NavItem, NavItemExt, SColor, STextStyles;

class SBottomBar extends StatelessWidget {
  const SBottomBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final void Function(int index) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: SColor.secTextColor.withOpacity(0.2),
          width: 0.4,
        ),
      ),
      child: StylishBottomBar(
        currentIndex: currentIndex,
        backgroundColor: SColor.backgroundColor,
        onTap: onTap,
        items: [
          ...NavItem.values.map(
            (item) => BottomBarItem(
              icon: Icon(
                item.index == currentIndex
                    ? item.selectedIcon
                    : item.unSelectedIcon,
                color: SColor.secTextColor,
              ),
              title: Text(
                item.label,
                style: STextStyles.s12W400.copyWith(color: SColor.secTextColor),
              ),
            ),
          ),
        ],
        option: AnimatedBarOptions(iconStyle: IconStyle.animated),
      ),
    );
  }
}
