import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart'; // STextStyles, SColor
import 'package:tc_sa/core/common/theme_provider.dart';
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

    // Use a fixed padding for the content area
    const contentPadding = EdgeInsets.symmetric(horizontal: 10.0);
                final colors = context.watch<ThemeProvider>().colors;

    return Scaffold(
      // 1. THEME UPDATE: White background
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<BlogViewModel>().getAllBlogs(),
          // 2. THEME UPDATE: Refresh color
          color: colors.amberDarkColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (with padding applied here)
                Padding(
                  padding: contentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Blogs', style: STextStyles.s24W600.copyWith(color: Colors.black)),
                      const SizedBox(height: 8),
                      Text(
                        'Explore Latest Blogs',
                        style: STextStyles.s16W400.copyWith(
                          color: Colors.grey.shade600, // Changed to dark grey
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                if (state == ViewState.busy)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      // 3. THEME UPDATE: Loader color
                      child: CircularProgressIndicator(color: colors.amberDarkColor),
                    ),
                  )
                else if (blogs.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      // 4. UI UPDATE: Modern 'Not Found' message
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
                      ),
                    ),
                  )
                else
                  // List (with horizontal padding applied to the surrounding Padding widget)
                  Padding(
                    padding: contentPadding,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: blogs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16), // Increased spacing
                      itemBuilder: (context, index) {
                        final b = blogs[index];
                        return _BlogCard(blog: b);
                      },
                    ),
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
    final title = blog.title ?? 'Untitled Blog';
    final highlight = blog.highlight ?? '';
    final description = blog.description ?? '';
    
    // Define a consistent dark amber color
    final Color darkAmber = Colors.black;

    return GestureDetector(
      onTap: () {
         context.pushNamed(RouteNames.blogResult, extra: blog);
      },
      child: Container(
        decoration: BoxDecoration(
          // 5. THEME UPDATE: Card styling (White background, light shadow, amber border)
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // Softer corners
          border: Border.all(color: Colors.amber.shade200, width: 1), // Lighter amber border
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(0.5), // Subtle grey shadow
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        // Removed outer margin as padding is added to the ListView parent
        // margin: const EdgeInsets.only(bottom: 4, right: 2, left: 2), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: STextStyles.s20W600.copyWith(color: Colors.black87, height: 1.3), // Black text
                maxLines: 2, // Limit title to 2 lines
                overflow: TextOverflow.ellipsis, // Add ellipses if truncated
              ),
              const SizedBox(height: 12),

              Text(
                description,
                style: TextStyle(color: Colors.grey.shade700, height: 1.5, fontSize: 14), // Darker grey for better readability
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),

              // Read More section (Now part of the main tap, but kept for visual style)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 7. THEME UPDATE: Read more color (Dark amber)
                  Text(
                    'Read full article',
                    style: TextStyle(color: darkAmber, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: darkAmber, size: 16), // Smaller, modern arrow
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}