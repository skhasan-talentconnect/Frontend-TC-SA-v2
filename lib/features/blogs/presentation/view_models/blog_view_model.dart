// lib/features/blogs/presentation/blog_view_model.dart
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';
import 'package:tc_sa/features/blogs/data/data_source/data_source_impl.dart';

class BlogViewModel extends ViewStateProvider {
  final BlogDataSourceImpl _blogService = BlogDataSourceImpl();

  List<BlogModel> _blogs = [];
  List<BlogModel> get blogs => _blogs;

  BlogModel? _selected;
  BlogModel? get selected => _selected;

  String? _message;
  String? get message => _message;

  Future<Failure?> getAllBlogs() async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _blogService.getAllBlogs();

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _blogs = [];
    }, (blogs) {
      _blogs = blogs;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<Failure?> getBlogById(String id) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _blogService.getBlogById(id);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
      _message = failure?.message;
      _selected = null;
    }, (blog) {
      _selected = blog;
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
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
      _message = failure?.message;
    }, (newBlog) {
      if (newBlog != null) {
        _blogs = [newBlog, ..._blogs];
      }
      _message = null;
    });

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }
}
