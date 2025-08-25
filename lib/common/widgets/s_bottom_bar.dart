import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tc_sa/common/index.dart'
    show NavItem, NavItemExt, SColor, STextStyles;

class SBottomBar extends StatefulWidget {
  const SBottomBar({required this.onTap, super.key});
  final void Function(int index) onTap;

  @override
  State<SBottomBar> createState() => _SBottomBarState();
}

class _SBottomBarState extends State<SBottomBar> {
  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder:
          (_, index, __) => Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: SColor.secTextColor.withOpacity(0.2),
                width: 0.4,
              ),
            ),
            child: StylishBottomBar(
              currentIndex: index,
              backgroundColor: SColor.backgroundColor,
              onTap: (newIndex) {
                currentIndex.value = newIndex;
                widget.onTap(newIndex);
              },
              items: [
                ...NavItem.values.map(
                  (item) => BottomBarItem(
                    icon: Icon(
                      item.index == currentIndex.value
                          ? item.selectedIcon
                          : item.unSelectedIcon,
                      color: SColor.secTextColor,
                    ),
                    title: Text(
                      item.label,
                      style: STextStyles.s12W400.copyWith(
                        color: SColor.secTextColor,
                      ),
                    ),
                  ),
                ),
              ],
              option: AnimatedBarOptions(iconStyle: IconStyle.animated),
            ),
          ),
    );
  }
}
