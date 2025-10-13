import 'package:flutter/material.dart';

class QuickHighlights extends StatelessWidget {
  final IconData icon; // <-- ADDED
  final String title;
  final String value;

  const QuickHighlights({
    super.key,
    required this.icon, // <-- ADDED
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28.0, color: Colors.purple), // <-- ADDED
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}