import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/faculty/data/entities/faculty-model.dart';


class FacultyMemberCard extends StatelessWidget {
  final FacultyMemberModel member;
  const FacultyMemberCard({super.key, required this.member});

  // Helper to get initials from name
  String getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = names.length > 2 ? 2 : names.length; // Max 2 initials
    for (var i = 0; i < numWords; i++) {
      if (names[i].isNotEmpty) {
        initials += names[i][0].toUpperCase();
      }
    }
    return initials.isEmpty ? '?' : initials;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initials = getInitials(member.name);

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero, // Margin is handled by ListView.separated
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.yellow.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Avatar with Initials (Yellow Theme) ---
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.amber.shade700, // Yellow background
              child: Text(
                initials,
                style: textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            
            // --- Details Column ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name ?? 'Unnamed Faculty',
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  if (member.qualification != null && member.qualification!.isNotEmpty)
                    Text(
                      member.qualification!,
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                    ),
                  const SizedBox(height: 12), // Increased spacing

                  // --- Info Chips (Yellow Theme) ---
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      // Experience Chip
                      if (member.experience != null && member.experience! > 0)
                        Chip(
                          avatar: Icon(Icons.work_history_outlined, size: 16, color: Colors.amber.shade800),
                          label: Text('${member.experience} years exp.'),
                          labelStyle: textTheme.labelMedium?.copyWith(color: Colors.amber.shade900),
                          backgroundColor: Colors.amber.shade50,
                          side: BorderSide(color: Colors.amber.shade200),
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.all(4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      
                      // Awards Chip (if any)
                      if (member.awards.isNotEmpty)
                        Chip(
                          avatar: Icon(Icons.emoji_events_outlined, size: 16, color: Colors.orange.shade800),
                          label: Text(member.awards.length == 1 ? member.awards.first : '${member.awards.length} Awards'),
                          labelStyle: textTheme.labelMedium?.copyWith(color: Colors.orange.shade900),
                          backgroundColor: Colors.orange.shade50,
                          side: BorderSide(color: Colors.orange.shade200),
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.all(4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}