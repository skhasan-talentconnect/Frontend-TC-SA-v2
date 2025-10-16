import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tc_sa/common/index.dart'
    show NavItem, NavItemExt, SColor, STextStyles;

class SBottomBar extends StatelessWidget {
  const SBottomBar({
    required this.currentIndex,
    required this.onTap,
    this.hasNewShortlist = false, // 1. Add the new property
    super.key,
  });

  final void Function(int index) onTap;
  final int currentIndex;
  final bool hasNewShortlist; // 2. Define it

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
          // 3. Update the mapping logic
          ...NavItem.values.map((item) {
            // Determine if this is the shortlist item.
            // Based on your HomeView, the shortlist index is 3.
            final bool isShortlistItem = item.index == 3;

            // Conditionally create the icon widget
            Widget iconWidget = Icon(
              item.index == currentIndex ? item.selectedIcon : item.unSelectedIcon,
              color: SColor.secTextColor,
            );

            // If it's the shortlist item AND there's a notification, wrap the icon in a Badge
            if (isShortlistItem && hasNewShortlist) {
              iconWidget = Badge(
                child: iconWidget,
              );
            }
            
            // Return the final BottomBarItem
            return BottomBarItem(
              icon: iconWidget,
              title: Text(
                item.label,
                style: STextStyles.s12W400.copyWith(color: SColor.secTextColor),
              ),
            );
          }),
        ],
        option: AnimatedBarOptions(iconStyle: IconStyle.animated),
      ),
    );
  }
}