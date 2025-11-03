import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/data/entities/admission-model.dart';

class TimelineCard extends StatelessWidget {
  final TimelineEntryModel timeline;
  const TimelineCard({super.key, required this.timeline});

  // --- 1. UPDATED COLORS ---
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Ongoing':
        return Colors.amber.shade700; // Changed from green
      case 'Starting Soon':
        return Colors.orange.shade700; // Changed from blue
      case 'Ended':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
  
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16.0),
      // --- 2. SET CARD BACKGROUND TO WHITE ---
      color: Colors.white, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    timeline.eligibility?.admissionLevel ?? 'Admission',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                // --- 3. STATUS CHIP WILL NOW USE NEW COLORS ---
                Chip(
                  label: Text(timeline.status ?? 'N/A'),
                  backgroundColor: _getStatusColor(timeline.status).withOpacity(0.1),
                  labelStyle: TextStyle(color: _getStatusColor(timeline.status), fontWeight: FontWeight.bold),
                  side: BorderSide(color: _getStatusColor(timeline.status)),
                ),
              ],
            ),
            InfoRow(icon: Icons.calendar_today_outlined, title: 'Starts On', value: _formatDate(timeline.admissionStartDate)),
            InfoRow(icon: Icons.event_available_outlined, title: 'Ends On', value: _formatDate(timeline.admissionEndDate)),
            const SizedBox(height: 12),
            if (timeline.eligibility?.ageCriteria != null && timeline.eligibility!.ageCriteria!.isNotEmpty)
              InfoRow(icon: Icons.cake_outlined, title: 'Age', value: timeline.eligibility!.ageCriteria!),
            if (timeline.eligibility?.otherInfo != null && timeline.eligibility!.otherInfo!.isNotEmpty)
              InfoRow(icon: Icons.info_outline, title: 'Info', value: timeline.eligibility!.otherInfo!),
            
            if (timeline.documentsRequired.isNotEmpty) ...[
        
              const Text('Documents Required', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                // --- 4. DOCUMENT CHIPS UPDATED TO YELLOW THEME ---
                children: timeline.documentsRequired.map((doc) => Chip(
                  label: Text(doc),
                  backgroundColor: Colors.amber.shade50,
                  side: BorderSide(color: Colors.amber.shade200),
                )).toList(),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  const InfoRow({super.key, required this.icon, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.yellow.shade700),
          const SizedBox(width: 12),
          Text('$title: ', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          Expanded(child: Text(value ?? 'N/A', style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}