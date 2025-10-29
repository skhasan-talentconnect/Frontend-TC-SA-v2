import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final Color primaryAmber = Colors.amber.shade700;
  final Color darkAmber = Colors.amber.shade800;
  final Color lightAmber = Colors.amber.shade100;

  @override
  void initState() {
    super.initState();
    // Use the actual likes count from the model
    currentLikes = widget.blog.likes ?? 0;
  }

  // Helper to format the date
  String _formatDate(String? dateString) {
    if (dateString == null) return 'Published recently';
    try {
      final dateTime = DateTime.parse(dateString);
      // Use timeago.format for a more human-readable "5 days ago" style
      return timeago.format(dateTime); 
    } catch (e) {
      return 'Published recently';
    }
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;
    final publishedDate = _formatDate(blog.createdAt);
    final hasHighlight = (blog.highlight ?? '').isNotEmpty;
    final hasContributors = (blog.contributor ?? []).isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow for a modern look
        title: const Text('Blog Article', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TITLE (The main headline)
            Text(
              blog.title ?? 'Untitled Article',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900, // Very bold
                color: Colors.black,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            // 2. HIGHLIGHT / SUBTITLE (Amber lead-in)
            if (hasHighlight) ...[
              Text(
                blog.highlight!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: darkAmber,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // 3. METADATA (Likes and Date)
            Row(
              children: [
                // Likes Counter
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      // Logic to visually toggle like count
                      currentLikes = isLiked ? currentLikes + 1 : currentLikes - 1;
                      // NOTE: A real implementation would call a ViewModel to update the backend here.
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: isLiked ? Colors.redAccent : Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${currentLikes}',
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Published Date
                Icon(Icons.access_time, size: 18, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(
                  publishedDate,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            const Divider(thickness: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 24),

            // 4. DESCRIPTION (The main content body)
            Text(
              blog.description ?? 'No description available for this blog.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.7, // Increased line height for easy reading
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),

            // 5. CONTRIBUTORS
            if (hasContributors) ...[
              const Text(
                'About the Author(s)',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              // Use ListView.separated to elegantly separate contributor cards
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: blog.contributor!.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _ContributorCard(name: blog.contributor![index]),
              ),
            ],
            const SizedBox(height: 16),
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
    final Color darkAmber = Colors.amber.shade800;
    final Color lightAmber = Colors.amber.shade100;

    return Row(
      children: [
        Container(
          width: 48, // Slightly larger avatar
          height: 48,
          decoration: BoxDecoration(
            color: lightAmber,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Center(
            child: Text(
              initial,
              style: TextStyle(
                fontSize: 20, // Larger initial
                fontWeight: FontWeight.bold,
                color: darkAmber,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600, 
                color: Colors.black87
              ),
            ),
            // Optional: Add a subtle 'Contributor' label
            Text(
              'Blog Contributor',
              style: TextStyle(
                fontSize: 13, 
                color: Colors.grey.shade500
              ),
            ),
          ],
        ),
      ],
    );
  }
}