import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/entities/feeAndScholarship_model.dart';

class ScholarshipCard extends StatelessWidget {
  // 2. Change the parameter type from Map to ScholarshipModel
  final ScholarshipModel scholarship;

  const ScholarshipCard({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    // 3. Access data safely using dot notation (e.g., scholarship.name)
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 1),
            color: Colors.black.withOpacity(0.2),
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
                backgroundColor: Colors.teal.shade100,
                avatar: const Icon(
                  Icons.category_outlined,
                  color: Colors.black,
                ),
              ),

            

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
                            backgroundColor: Colors.white,
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
