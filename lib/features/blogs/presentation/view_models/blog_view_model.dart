import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';

import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';
import 'package:tc_sa/features/blogs/data/data_source/data_source_impl.dart';

class BlogViewModel extends ViewStateProvider {
  final BlogDataSourceImpl _blogService = BlogDataSourceImpl();
  List<BlogModel> _blogs = [];

  List<BlogModel> get blogs => _blogs;

  Future<Failure?> getAllBlogs() async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _blogService.getAllBlogs();

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (blogs) {
      _blogs = blogs;
    });

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getBlogById(String id) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _blogService.getBlogById(id);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (blog) {
      // Handle the single blog if needed
    });

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> createBlog({
    required String title,
    required String highlight,
    required String description,
    required List<String> contributor,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _blogService.createBlog(
      title: title,
      highlight: highlight,
      description: description,
      contributor: contributor,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (newBlog) {
      // Add the new blog to the list or handle as needed
      _blogs.insert(0, newBlog);
    });

    setViewState(ViewState.complete);

    return failure;
  }
}