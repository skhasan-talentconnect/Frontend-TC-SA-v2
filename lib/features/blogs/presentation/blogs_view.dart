import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart'; // STextStyles, SColor
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/navigation/route_name.dart';
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';
import 'package:tc_sa/features/blogs/presentation/view_models/blog_view_model.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogViewModel()..getAllBlogs(),
      child: const _BlogPageBody(),
    );
  }
}

class _BlogPageBody extends StatelessWidget {
  const _BlogPageBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BlogViewModel>();
    final state = vm.viewState;
    final blogs = vm.blogs;

    return Scaffold(
      // --- 1. THEME UPDATE: White background ---
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<BlogViewModel>().getAllBlogs(),
          // --- 2. THEME UPDATE: Refresh color ---
          color: Colors.amber,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // Added consistent padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Blogs', style: STextStyles.s24W600),
                const SizedBox(height: 8),
                Text(
                  'Explore Latest Blogs',
                  style: STextStyles.s16W400.copyWith(
                    color: SColor.terTextColor,
                  ),
                ),
                const SizedBox(height: 16),

                if (state == ViewState.busy)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      // --- 3. THEME UPDATE: Loader color ---
                      child: CircularProgressIndicator(color: Colors.amber),
                    ),
                  )
                else if (blogs.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      // --- 4. UI UPDATE: Modern 'Not Found' message ---
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article_outlined, size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            vm.message ?? 'No blogs available',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      )
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16), // Increased spacing
                    itemBuilder: (context, index) {
                      final b = blogs[index];
                      return _BlogCard(blog: b);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  const _BlogCard({required this.blog});
  final BlogModel blog;

  @override
  Widget build(BuildContext context) {
    final title = blog.title ?? '';
    final highlight = blog.highlight ?? '';
    final description = blog.description ?? '';

    return Container(
      decoration: BoxDecoration(
        // --- 5. THEME UPDATE: Card styling ---
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Softer corners
        border: Border.all(color: Colors.amber.shade300, width: 1), // Yellow border
        boxShadow: [
          BoxShadow(
            color: Colors.amber.shade100.withOpacity(0.5), // Yellow shadow
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 4, right: 2, left: 2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (highlight.isNotEmpty)
              Text(
                highlight,
                // --- 6. THEME UPDATE: Highlight text color ---
                style: STextStyles.s16W600.copyWith(color: Colors.amber.shade800),
              ),
            const SizedBox(height: 12),

            Text(title, style: STextStyles.s20W600),
            const SizedBox(height: 12),

            Text(
              description,
              style: const TextStyle(color: Colors.grey, height: 1.5), // Added line height
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                context.pushNamed(RouteNames.blogResult, extra: blog);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- 7. THEME UPDATE: Read more color ---
                  Text(
                    'Read more',
                    style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.amber.shade900),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}