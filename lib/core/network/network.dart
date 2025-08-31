import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;
import 'package:tc_sa/core/network/endpoints.dart' show Endpoints;
import 'package:tc_sa/core/network/request.dart' show Request;
import 'package:tc_sa/core/services/secret_repo.dart';

class NetworkService {
  NetworkService() {
    final extraInterceptors = <Interceptor>[];

    if (kDebugMode) {
      extraInterceptors.add(
        PrettyDioLogger(responseBody: true, requestBody: true),
      );
    }

    _dio = Dio()..interceptors.addAll(extraInterceptors);
    _dio.options.baseUrl = Endpoints.baseUrl;
  }

  late Dio _dio;

  Future<Response<dynamic>> request(Request request) async {
    final method = request.method.name;

    final headers = Map<String, String>.from(request.headers ?? {});

    if (request.isSafeRoute) {
      final token = await SecretRepo.getString('auth_token');
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return _dio.request(
      request.endpoint,
      data: request.body,
      queryParameters: request.queryParams,
      options: Options(method: method, headers: headers),
    );
  }
}
