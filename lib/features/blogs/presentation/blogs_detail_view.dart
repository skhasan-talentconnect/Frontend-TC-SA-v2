import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router for context.pop()
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';
import 'package:timeago/timeago.dart' as timeago; // Import for date formatting

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

  // Helper to format the date
  String _formatDate(String? dateString) {
    if (dateString == null) return 'Published recently';
    try {
      final dateTime = DateTime.parse(dateString);
      return timeago.format(dateTime);
    } catch (e) {
      return 'Published recently';
    }
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;
    final publishedDate = _formatDate(blog.createdAt);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Blog Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // --- NAVIGATION FIX: Use context.pop() ---
          onPressed: () => context.pop(),
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  // --- THEME UPDATE ---
                  color: Colors.amber.shade800,
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
                      // This logic only visually toggles, it doesn't update the backend
                      currentLikes = isLiked ? (widget.blog.likes ?? 0) + 1 : (widget.blog.likes ?? 0);
                    });
                  },
                  child: Icon(
                    // --- THEME UPDATE: Use filled heart ---
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    // --- THEME UPDATE: Use yellow for liked ---
                    color: isLiked ? Colors.redAccent : Colors.grey,
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
                Text(
                  publishedDate, // Use formatted date
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- UI UPDATE: Added a divider ---
            const Divider(thickness: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 16),

            Text(
              blog.description ?? '',
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
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
              // --- THEME UPDATE ---
              color: Colors.amber.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // --- THEME UPDATE ---
                  color: Colors.amber.shade800,
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