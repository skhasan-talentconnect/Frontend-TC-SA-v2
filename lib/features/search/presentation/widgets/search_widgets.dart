// search_widgets.dart
import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';


class SearchGridSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Set<String> selectedItems;
  final Function(String) onTap;
  final Color selectedColor;
  final bool isGreyBox;

  const SearchGridSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onTap,
    required this.selectedColor,
    required this.isGreyBox,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: STextStyles.s22W600,
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return GestureDetector(
              onTap: () => onTap(item),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: isSelected
                      ? Border.all(
                          color: selectedColor,
                          width: 2,
                        )
                      : null,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
                child: Center(
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: STextStyles.s15W400.copyWith(color: SColor.primaryColor),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SearchStreamSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Set<String> selectedItems;
  final Function(String) onTap;
  final Color selectedColor;

  const SearchStreamSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onTap,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            title,
            style: STextStyles.s22W600.copyWith(color: SColor.primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              final isSelected = selectedItems.contains(item);
              return GestureDetector(
                onTap: () => onTap(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? selectedColor : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    item,
                    style: STextStyles.s16W400.copyWith(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color cursorColor;
  final Function() onSearchPressed;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.cursorColor,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: STextField(
        controller: controller,
        hint: "Search here...",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onSearchPressed,
          child: Text(
            "Search",
            style: TextStyle(color: cursorColor),
          ),
        ),
      ),
    );
  }
}