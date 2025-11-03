import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/entities/feeAndScholarship_model.dart';

class ScholarshipCard extends StatelessWidget {
  final ScholarshipModel scholarship;

  const ScholarshipCard({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // --- THEME UPDATE: Yellow border and shadow ---
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(0, 3),
            color: Colors.amber.shade100.withOpacity(0.5),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scholarship.name ?? 'Unnamed Scholarship',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Only show the chip if a type exists
            if (scholarship.type != null)
              Chip(
                label: Text(scholarship.type!),
                // --- THEME UPDATE: Yellow chip ---
                backgroundColor: Colors.amber.shade100,
                avatar: Icon(
                  Icons.category_outlined,
                  color: Colors.amber.shade800,
                ),
                labelStyle: TextStyle(color: Colors.amber.shade900),
                side: BorderSide(color: Colors.amber.shade300),
              ),
            
           SizedBox(height: 20),

            Text(
              'Amount: ₹${scholarship.amount ?? 0}',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            // Only show the "Documents" section if the list is not empty
            if (scholarship.documentsRequired.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Documents Required:',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children:
                    scholarship.documentsRequired
                        .map(
                          (doc) => Chip(
                            // --- THEME UPDATE: Lighter chip ---
                            backgroundColor: Colors.grey.shade100,
                            label: Text(doc),
                          ),
                        )
                        .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}