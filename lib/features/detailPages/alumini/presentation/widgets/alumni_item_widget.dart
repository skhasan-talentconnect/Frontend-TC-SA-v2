// features/detailPages/alumini/presentation/widgets/alumni_item_widget.dart
import 'package:flutter/material.dart';

class AlumniItemWidget extends StatelessWidget {
  final String name;
  final String? profession;
  final String? percentage;

  /// Use either backgroundGradient OR backgroundColor (gradient takes precedence)
  final List<Color>? backgroundGradient;
  final Color? backgroundColor;

  const AlumniItemWidget({
    super.key,
    required this.name,
    this.profession,
    this.percentage,
    this.backgroundGradient,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasGradient = backgroundGradient != null && backgroundGradient!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasGradient ? null : (backgroundColor ?? const Color(0xFFF7F9FC)),
        gradient: hasGradient
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: backgroundGradient!,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
        // --- 1. THEME UPDATE ---
        border: Border.all(
          color: Colors.amber.shade300,
          width: 1,
        ),
        // --- 2. THEME UPDATE ---
        boxShadow: [
          BoxShadow(
            color: Colors.amber.shade100.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (profession != null && profession!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    profession!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B), // slate-500ish
                    ),
                  ),
                ],
              ],
            ),
          ),
          // right
          if (percentage != null && percentage!.isNotEmpty)
            Text(
              percentage!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // --- 3. THEME UPDATE ---
                color: Colors.amber.shade800,
              ),
            ),
        ],
      ),
    );
  }
}