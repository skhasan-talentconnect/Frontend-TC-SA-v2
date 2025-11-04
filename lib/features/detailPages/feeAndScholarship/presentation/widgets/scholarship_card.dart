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
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.grey,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Scholarship Name ---
            Text(
              scholarship.name ?? 'Unnamed Scholarship',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // --- Type Chip (if available) ---
            if (scholarship.type != null)
              Chip(
                label: Text(scholarship.type!),
                backgroundColor: Colors.amber.shade100,
                avatar: Icon(
                  Icons.category_outlined,
                  color: Colors.amber.shade800,
                ),
                labelStyle: TextStyle(color: Colors.amber.shade900),
                side: BorderSide(color: Colors.amber.shade300),
              ),

            const SizedBox(height: 20),

            // --- Amount ---
            Text(
              'Amount: ₹${scholarship.amount ?? 0}',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            // --- Documents Section ---
            if (scholarship.documentsRequired.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Documents Required:',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: scholarship.documentsRequired
                    .map(
                      (doc) => Chip(
                        backgroundColor: Colors.amber.shade50,
                        label: Text(doc),
                         side: BorderSide(color: Colors.amber.shade200),
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
