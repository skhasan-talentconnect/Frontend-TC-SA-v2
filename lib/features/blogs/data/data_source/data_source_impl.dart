// lib/features/blogs/data/data_source/data_source_impl.dart
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show NetworkService, ResultFuture, Request, RequestMethod, APIException, Endpoints;
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';
import 'package:tc_sa/features/blogs/data/data_source/data_source.dart';

class BlogDataSourceImpl implements BlogDataSource {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<List<BlogModel>> getAllBlogs() async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: Endpoints.adminBlogs,
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response['status'] == 'success') {
        final list = (response['data'] as List?) ?? const [];
        final blogs = list
            .whereType<Map<String, dynamic>>()
            .map((e) => BlogModel.fromJson(e))
            .toList();
        return Right(blogs);
      }
 return Left(APIException.from(e));    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<BlogModel?> getBlogById(String id) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.adminBlogs}/$id',
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response['status'] == 'success' && response['data'] != null) {
        final blog = BlogModel.fromJson(response['data'] as Map<String, dynamic>);
        return Right(blog);
      }
 return Left(APIException.from(e));    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<BlogModel?> createBlog({
    required String title,
    required String highlight,
    required String description,
    required List<String> contributor,
  }) async {
    final request = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminBlogs,
      body: {
        'title': title,
        'highlight': highlight,
        'description': description,
        'contributor': contributor,
      },
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response['status'] == 'success' && response['data'] != null) {
        final blog = BlogModel.fromJson(response['data'] as Map<String, dynamic>);
        return Right(blog);
      }
      return Left(APIException.from(e));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
