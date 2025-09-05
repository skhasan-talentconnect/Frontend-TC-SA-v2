import 'package:flutter/material.dart';

class ReviewsWidgets {
  static Widget buildStarRating(double rating, {double iconSize = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          return Icon(Icons.star, color: Colors.amber, size: iconSize);
        } else if (rating > index) {
          return Icon(Icons.star_half, color: Colors.amber, size: iconSize);
        } else {
          return Icon(
            Icons.star_border,
            color: Colors.amber,
            size: iconSize,
          );
        }
      }),
    );
  }

  static Widget buildRatingBar(String label, int percent) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent / 100,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$percent%",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  static Widget buildReviewItem(
    String name,
    String role,
    String review,
    double rating,
    String date,
    int likes,
    int comments,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                buildStarRating(rating, iconSize: 18),
                Text(
                  role,
                  style: const TextStyle(
                    color: Color(0xFF42A5F5),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  review,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up, size: 20),
                      onPressed: () {},
                    ),
                    Text("$likes"),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.comment, size: 20),
                      onPressed: () {},
                    ),
                    Text("$comments"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void showReviewDialog(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    int selectedRating = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Write a Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reviewController,
                    cursorColor: Colors.blue,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Write your thoughts here...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setModalState(() {
                            selectedRating = index + 1;
                          });
                        },
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 35,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Review submitted successfully!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}