import 'package:tc_sa/core/network/endpoints.dart';

enum RequestMethod { get, post, put, patch, delete }

class Request {
  Request({
    required this.method,
    required this.endpoint,
    this.queryParams = const {},
    this.body,
    this.headers,
    this.isSafeRoute = false, 
  });

  final String endpoint;
  final Map<String, dynamic> queryParams;
  final Map<String, String>? headers;
  final dynamic body;
  final bool isSafeRoute;

  final RequestMethod method;

  String get fullPath => '${Endpoints.baseUrl}$endpoint';

  String get realPath => endpoint;
}
