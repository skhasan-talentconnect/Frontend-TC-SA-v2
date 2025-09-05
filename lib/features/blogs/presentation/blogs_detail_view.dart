import 'package:flutter/material.dart';
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';

class BlogPageDetail extends StatefulWidget {
  final BlogModel blog;
  const BlogPageDetail({super.key, required this.blog});

  @override
  State<BlogPageDetail> createState() => _BlogPageDetailState();
}

class _BlogPageDetailState extends State<BlogPageDetail> {
  bool isLiked = false;
  late int currentLikes;

  @override
  void initState() {
    super.initState();
    currentLikes = widget.blog.likes ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Blog Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((blog.highlight ?? '').isNotEmpty)
              Text(
                blog.highlight!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            const SizedBox(height: 16),

            Text(
              blog.title ?? '',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      currentLikes = isLiked ? (blog.likes ?? 0) + 1 : (blog.likes ?? 0);
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '$currentLikes',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text(
                  'Published recently',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              blog.description ?? '',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            if ((blog.contributor ?? []).isNotEmpty) ...[
              const Text(
                'Contributors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Column(
                children: blog.contributor!
                    .map((name) => _ContributorCard(name: name))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ContributorCard extends StatelessWidget {
  const _ContributorCard({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
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
                initial,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
