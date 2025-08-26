import 'package:flutter/material.dart';

class BlogPageDetail extends StatefulWidget {
  final String title;
  final String highlight;
  final String description;
  final List<String> contributors;
  final int likes;

  const BlogPageDetail({
    super.key,
    required this.title,
    required this.highlight,
    required this.description,
    required this.contributors,
    required this.likes,
  });

  @override
  State<BlogPageDetail> createState() => _BlogPageDetailState();
}

class _BlogPageDetailState extends State<BlogPageDetail> {
  bool isLiked = false;
  int currentLikes = 0;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Blog Detail',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Highlight section
              Text(
                widget.highlight,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),

              // Title section
              Text(
                widget.title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Likes and date section
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                        if (isLiked) {
                          currentLikes = widget.likes + 1;
                        } else {
                          currentLikes = widget.likes;
                        }
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '$currentLikes',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'Published recently',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Description section
              Text(
                widget.description,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 24),

              // Contributors section
              if (widget.contributors.isNotEmpty) ...[
                Text(
                  'Contributors',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Column(
                  children: [
                    for (var contributor in widget.contributors)
                      contributorCard(contributor),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Contributor Card Widget
  Widget contributorCard(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0] : '?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}