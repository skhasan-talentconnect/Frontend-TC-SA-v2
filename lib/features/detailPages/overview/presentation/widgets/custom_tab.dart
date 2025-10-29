import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({required this.tabName, required this.isSelected, super.key});
  final String tabName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tabName,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
