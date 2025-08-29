import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart'
    show NetworkService, ResultFuture, Request, RequestMethod, APIException, Endpoints;
import 'package:tc_sa/features/blogs/data/entities/blog_model.dart';

class BlogDataSourceImpl {
  final NetworkService _networkService = NetworkService();

  ResultFuture<List<BlogModel>> getAllBlogs() async {
    Request request = Request(
      method: RequestMethod.get,
      endpoint:Endpoints.adminBlogs,
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;
      
      if (response['status'] == 'success') {
        final blogsData = response['data'] as List;
        final blogs = blogsData.map((blogJson) => BlogModel.fromJson(blogJson)).toList();
        return Right(blogs);
      } else {
        return Left(APIException.from(e));
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  ResultFuture<BlogModel> getBlogById(String id) async {
    Request request = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.adminBlogs}/$id',
   
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;
      
      if (response['status'] == 'success') {
        final blog = BlogModel.fromJson(response['data']);
        return Right(blog);
      } else {
        return Left(APIException.from(e));
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  ResultFuture<BlogModel> createBlog({
    required String title,
    required String highlight,
    required String description,
    required List<String> contributor,
  }) async {
    Request request = Request(
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
      
      if (response['status'] == 'success') {
        final blog = BlogModel.fromJson(response['data']);
        return Right(blog);
      } else {
        return Left(APIException.from(e));
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}