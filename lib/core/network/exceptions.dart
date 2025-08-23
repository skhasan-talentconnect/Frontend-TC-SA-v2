import 'package:dio/dio.dart';
import 'package:tc_sa/core/extensions/dio_exception_ext.dart';

class APIException implements Exception {
  APIException({required this.message, required this.statusCode});

  final String? message;
  final int? statusCode;

  factory APIException.from(dynamic e) => APIException(
    message: (e is DioException) ? e.getErrorFromResponse() : e.toString(),
    statusCode: (e is DioException) ? e.getStatusCodeFromResponse() : 500,
  );
}
