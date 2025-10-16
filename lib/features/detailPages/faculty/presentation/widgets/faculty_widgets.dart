import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/faculty/data/entities/faculty-model.dart';


class FacultyMemberCard extends StatelessWidget {
  final FacultyMemberModel member;
  const FacultyMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member.name ?? 'Unnamed Faculty',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              member.qualification ?? 'N/A',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
   
            Row(
              children: [
                const Icon(Icons.work_history_outlined, size: 20, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  '${member.experience ?? 0} years of experience',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (member.awards.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Icon(Icons.emoji_events_outlined, size: 20, color: Colors.amber),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      member.awards.join(', '),
                      style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}