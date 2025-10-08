import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String reviewText;
  final double rating;
  final String timeAgo;
  final int likes;

  const ReviewCard({
    super.key,
    required this.name,
    required this.reviewText,
    required this.rating,
    required this.timeAgo,
    required this.likes,
  });

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
            Row(
              children: [
                CircleAvatar(child: Text(name.isNotEmpty ? name.substring(0, 1) : 'A')),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          ...List.generate(5, (index) => Icon(
                            index < rating.round() ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          )),
                          const SizedBox(width: 8),
                          Text(timeAgo, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(reviewText, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text('$likes'),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('Reply')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}