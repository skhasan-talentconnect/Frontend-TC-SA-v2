import 'package:flutter/material.dart';
import 'package:tc_sa/features/blogs/blog_model.dart';
import 'package:tc_sa/features/blogs/blogs_detail_view.dart';
import 'package:tc_sa/features/predictor/predictor_view.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Predefined blog data
    List<BlogModel> blogs = [
      BlogModel(
        title: "The Future of Education Technology",
        highlight: "Exploring how AI is transforming classrooms",
        description: "Artificial intelligence is revolutionizing the way we teach and learn. From personalized learning paths to automated grading systems, AI is making education more accessible and effective for students worldwide.",
        contributor: ["Dr. Sarah Johnson", "Prof. Michael Chen"],
        likes: 42,
      ),
      BlogModel(
        title: "Sustainable Campus Initiatives",
        highlight: "How universities are going green",
        description: "Colleges around the world are implementing innovative sustainability programs. Learn about solar power installations, zero-waste initiatives, and eco-friendly transportation options on modern campuses.",
        contributor: ["Environmental Club"],
        likes: 28,
      ),
      BlogModel(
        title: "Mental Health Resources for Students",
        highlight: "Supporting student wellbeing in challenging times",
        description: "Mental health is a critical aspect of student success. This article explores the various resources available to students and how institutions can better support mental wellbeing on campus.",
        contributor: ["Dr. Emily Rodriguez", "Counseling Center Staff"],
        likes: 56,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page header section
                Text(
                  'Blogs',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Explore Latest Blogs',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),

                // Featured blog posts container
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section title
                      Text(
                        'Featured blog posts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Blog cards list
                      ListView.builder(
                        itemCount: blogs.length,
                        itemBuilder: (context, index) {
                          return BlogCard(
                            title: blogs[index].title ?? '',
                            highlight: blogs[index].highlight ?? '',
                            description: blogs[index].description ?? '',
                            blog: blogs[index],
                          );
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
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

class BlogCard extends StatelessWidget {
  final String title;
  final String highlight;
  final String description;
  final BlogModel blog;

  const BlogCard({
    super.key,
    required this.title,
    required this.highlight,
    required this.description,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog highlight section
            Text(
              highlight,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),

            // Blog title section
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // Blog description section
            Text(
              description, 
              style: TextStyle(color: Colors.grey), 
              maxLines: 3, 
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),

            // Read more button section
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogPageDetail(
                      title: blog.title ?? '',
                      highlight: blog.highlight ?? '',
                      description: blog.description ?? '',
                      contributors: blog.contributor ?? [],
                      likes: blog.likes ?? 0,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Read more',
                    style: TextStyle(color: Colors.black),
                  ),
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
