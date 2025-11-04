// features/detailPages/alumini/presentation/widgets/alumni_item_widget.dart
import 'package:flutter/material.dart';

class AlumniItemWidget extends StatelessWidget {
  final String name;
  final String? profession;
  final String? percentage;

  const AlumniItemWidget({
    super.key,
    required this.name,
    this.profession,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.amber.shade100.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- Left Side: Name & Profession ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (profession != null && profession!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    profession!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B), // subtle grey tone
                    ),
                  ),
                ],
              ],
            ),
          ),

          // --- Right Side: Percentage ---
          if (percentage != null && percentage!.isNotEmpty)
            Text(
              percentage!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
        ],
      ),
    );
  }
}
