import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';

abstract class BlogDataSource {
  /// Retrieves all blogs from the server
  /// Returns either an APIException or a list of BlogModel objects
  ResultFuture<List<BlogModel>> getAllBlogs();

  /// Retrieves a specific blog by its ID
  /// Returns either an APIException or a BlogModel object
  ResultFuture<BlogModel> getBlogById(String id);

  /// Creates a new blog with the provided details
  /// Returns either an APIException or the created BlogModel object
  ResultFuture<BlogModel> createBlog({
    required String title,
    required String highlight,
    required String description,
    required List<String> contributor,
  });
}