// lib/features/application/pdfModule/data/data_source/pdf_data_source_impl.dart
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tc_sa/core/index.dart'
    show ResultFuture, Request, NetworkService, RequestMethod, Endpoints, getIt, APIException;
import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source.dart';

class StudentPdfDataSourceImpl implements StudentPdfDataSource {
  final NetworkService _network = getIt<NetworkService>();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl, // e.g. https://backend-tc-sa-v2.onrender.com
    responseType: ResponseType.bytes,
    headers: {'Accept': 'application/pdf'},
    receiveDataWhenStatusError: true,
    followRedirects: true,
    validateStatus: (code) => code != null && code >= 200 && code < 400,
  ));

  bool _isBlank(String? s) => s == null || s.trim().isEmpty;

  @override
  ResultFuture<bool> generatePdf({String? studId}) async {
    if (_isBlank(studId)) {
      return Left(APIException(message: 'Missing studId', statusCode: 400));
    }
    try {
      final r = Request(
        method: RequestMethod.post,
        endpoint: "${Endpoints.users}/pdf/generate/$studId",
      );
      final res = await _network.request(r);
      final map = res.data as Map<String, dynamic>?;
      final ok = (map?['message']?.toString() ?? '').toLowerCase().contains('pdf generated');
      return Right(ok);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<List<int>?> viewPdfBytes({String? studId}) async {
    if (_isBlank(studId)) {
      return Left(APIException(message: 'Missing studId', statusCode: 400));
    }
    try {
      final resp = await _dio.get<List<int>>("users/pdf/view/$studId");
      return Right(resp.data);
    } on DioException catch (e) {
      // Try to extract message from server or raw bytes
      String? msg;
      final data = e.response?.data;
      if (data is List<int>) {
        msg = utf8.decode(data, allowMalformed: true);
      } else if (data is String) {
        msg = data;
      }
      return Left(APIException(
        message: msg?.isNotEmpty == true ? msg : e.message ?? 'PDF view failed',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<List<int>?> downloadPdfBytes({String? studId}) async {
    if (_isBlank(studId)) {
      return Left(APIException(message: 'Missing studId', statusCode: 400));
    }
    try {
      final resp = await _dio.get<List<int>>("users/pdf/download/$studId");
      return Right(resp.data);
    } on DioException catch (e) {
      String? msg;
      final data = e.response?.data;
      if (data is List<int>) {
        msg = utf8.decode(data, allowMalformed: true);
      } else if (data is String) {
        msg = data;
      }
      return Left(APIException(
        message: msg?.isNotEmpty == true ? msg : e.message ?? 'PDF download failed',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
