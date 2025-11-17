import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:tc_sa/core/index.dart'
    show ResultFuture, Request, NetworkService, RequestMethod, getIt, APIException;

import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source.dart';

class StudentPdfDataSourceImpl implements StudentPdfDataSource {
  final NetworkService _network = getIt<NetworkService>();

  // BASE URL
  static const String _baseUrl = 'https://backend-tc-sa-v2.onrender.com/api/users/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      responseType: ResponseType.bytes,
      headers: {'Accept': 'application/pdf'},
      receiveDataWhenStatusError: true,
      followRedirects: true,
      validateStatus: (c) => c != null && c >= 200 && c < 400,
    ),
  );

  bool _isBlank(String? s) => s == null || s.trim().isEmpty;

  // ------------------------------------------------------------
  // ★ GENERATE PDF
  // ------------------------------------------------------------
  @override
  ResultFuture<bool> generatePdf({
    required String studId,
    required String applicationId,
  }) async {
    if (_isBlank(studId) || _isBlank(applicationId)) {
      return Left(APIException(message: "Missing IDs", statusCode: 400));
    }

    try {
      final endpoint = "${_baseUrl}pdf/generate/$studId/$applicationId";

      final r = Request(
        method: RequestMethod.post,
        endpoint: endpoint,
      );

      final res = await _network.request(r);
      final map = res.data as Map<String, dynamic>?;

      final ok = (map?["message"] ?? "")
          .toString()
          .toLowerCase()
          .contains("pdf generated");

      return Right(ok);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  // ------------------------------------------------------------
  // ★ VIEW PDF
  // ------------------------------------------------------------
  @override
  ResultFuture<List<int>?> viewPdfBytes({
    required String studId,
    required String applicationId,
  }) async {
    if (_isBlank(studId) || _isBlank(applicationId)) {
      return Left(APIException(message: "Missing IDs", statusCode: 400));
    }

    try {
      final url = "${_baseUrl}pdf/view/$studId/$applicationId";
      final resp = await _dio.get<List<int>>(url);
      return Right(resp.data);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  // ------------------------------------------------------------
  // ★ DOWNLOAD PDF
  // ------------------------------------------------------------
  @override
  ResultFuture<List<int>?> downloadPdfBytes({
    required String studId,
    required String applicationId,
  }) async {
    if (_isBlank(studId) || _isBlank(applicationId)) {
      return Left(APIException(message: "Missing IDs", statusCode: 400));
    }

    try {
      final url = "${_baseUrl}pdf/download/$studId/$applicationId";
      final resp = await _dio.get<List<int>>(url);
      return Right(resp.data);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
