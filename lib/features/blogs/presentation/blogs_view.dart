import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:tc_sa/common/index.dart'; // STextStyles, SColor
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/navigation/route_name.dart';
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';

import 'package:tc_sa/features/blogs/presentation/view_models/blog_view_model.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide BlogViewModel here so descendants can watch/read it.
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<BlogViewModel>().getAllBlogs(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Blogs', style: STextStyles.s24W600),
                const SizedBox(height: 8),
                Text(
                  'Explore Latest Blogs',
                  style: STextStyles.s16W400.copyWith(color: SColor.terTextColor),
                ),
                const SizedBox(height: 16),

                if (state == ViewState.busy)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (blogs.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text(vm.message ?? 'No blogs available'),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
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
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 4, right: 1, left: 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (highlight.isNotEmpty)
              Text(
                highlight,
                style: STextStyles.s16W600.copyWith(color: SColor.primaryColor),
              ),
            const SizedBox(height: 12),

            Text(title, style: STextStyles.s20W600),
            const SizedBox(height: 12),

            Text(
              description,
              style: const TextStyle(color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                // GoRouter navigation with extra payload
                context.pushNamed(
                  RouteNames.blogResult,
                  extra: blog,
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Read more', style: TextStyle(color: Colors.black)),
                  Icon(Icons.arrow_forward, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
