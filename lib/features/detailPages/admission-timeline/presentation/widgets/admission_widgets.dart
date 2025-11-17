import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/common/theme_provider.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/data/entities/admission-model.dart';

class TimelineCard extends StatelessWidget {
  final TimelineEntryModel timeline;
  const TimelineCard({super.key, required this.timeline});

  // --- 1. STATUS COLORS ---
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Ongoing':
        return Colors.amber.shade700;
      case 'Starting Soon':
        return Colors.orange.shade700;
      case 'Ended':
        return Colors.grey;
      default:
        return Colors.black87;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
     final colors = context.watch<ThemeProvider>().colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER ROW ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  timeline.eligibility?.admissionLevel ?? 'Admission',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
              ),
              Chip(
                label: Text(timeline.status ?? 'N/A'),
                backgroundColor: _getStatusColor(timeline.status).withValues(alpha:0.1),
                labelStyle: TextStyle(
                  color: _getStatusColor(timeline.status),
                  fontWeight: FontWeight.bold,
                ),
                side: BorderSide(color: _getStatusColor(timeline.status)),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // --- INFO ROWS ---
          InfoRow(
            icon: Icons.calendar_today_outlined,
            title: 'Starts On',
            value: _formatDate(timeline.admissionStartDate),
          ),
          InfoRow(
            icon: Icons.event_available_outlined,
            title: 'Ends On',
            value: _formatDate(timeline.admissionEndDate),
          ),
          const SizedBox(height: 12),

          if (timeline.eligibility?.ageCriteria != null &&
              timeline.eligibility!.ageCriteria!.isNotEmpty)
            InfoRow(
              icon: Icons.cake_outlined,
              title: 'Age',
              value: timeline.eligibility!.ageCriteria!,
            ),
          if (timeline.eligibility?.otherInfo != null &&
              timeline.eligibility!.otherInfo!.isNotEmpty)
            InfoRow(
              icon: Icons.info_outline,
              title: 'Info',
              value: timeline.eligibility!.otherInfo!,
            ),

          if (timeline.documentsRequired.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Documents Required',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: timeline.documentsRequired
                  .map(
                    (doc) => Chip(
                      label: Text(doc),
                      backgroundColor: colors.amberLightColor,
                      side: BorderSide(color: colors.amberMedColor),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
     final colors = context.watch<ThemeProvider>().colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: colors.topTextColor),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
