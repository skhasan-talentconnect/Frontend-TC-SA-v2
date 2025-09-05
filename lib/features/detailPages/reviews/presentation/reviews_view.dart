import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/widgets/reviews_widgets.dart';


class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Predefined data
    final double averageRating = 4.3;
    final List<int> percents = [45, 30, 15, 7, 3];
    
    final List<Map<String, dynamic>> reviews = [
      {
        "name": "Rahul Sharma",
        "role": "Computer Science Student",
        "review": "Excellent faculty and infrastructure. The campus is well-maintained and has all the necessary facilities for students.",
        "rating": 5.0,
        "date": "2 weeks ago",
        "likes": 12,
        "comments": 3
      },
      {
        "name": "Priya Patel",
        "role": "Alumni - Batch of 2020",
        "review": "Great learning experience with dedicated teachers. The placement opportunities are good for motivated students.",
        "rating": 4.0,
        "date": "1 month ago",
        "likes": 8,
        "comments": 2
      },
      {
        "name": "Amit Kumar",
        "role": "Current Student",
        "review": "Good college overall, but could improve in some areas like hostel facilities and sports infrastructure.",
        "rating": 3.5,
        "date": "3 days ago",
        "likes": 5,
        "comments": 1
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Reviews & Ratings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ReviewsWidgets.buildStarRating(averageRating),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    ReviewsWidgets.showReviewDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    "Write a Review",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Rating distribution
            ReviewsWidgets.buildRatingBar("5 star", percents[0]),
            const SizedBox(height: 8),
            ReviewsWidgets.buildRatingBar("4 star", percents[1]),
            const SizedBox(height: 8),
            ReviewsWidgets.buildRatingBar("3 star", percents[2]),
            const SizedBox(height: 8),
            ReviewsWidgets.buildRatingBar("2 star", percents[3]),
            const SizedBox(height: 8),
            ReviewsWidgets.buildRatingBar("1 star", percents[4]),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Review list
            ...reviews.map((review) {
              return ReviewsWidgets.buildReviewItem(
                review["name"],
                review["role"],
                review["review"],
                review["rating"],
                review["date"],
                review["likes"],
                review["comments"],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}