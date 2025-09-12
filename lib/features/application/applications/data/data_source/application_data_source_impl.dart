import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart'
    show
        Request,
        RequestMethod,
        NetworkService,
        Endpoints,
        APIException,
        getIt,
        AppStateProvider;
import 'package:tc_sa/features/application/applications/data/data_source/application_data_source.dart';
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';

class ApplicationDataSourceImpl implements ApplicationDataSource {
  final NetworkService _network = getIt<NetworkService>();
  final AppStateProvider _app = getIt<AppStateProvider>();

  /// Base: Endpoints.applications (e.g. "/applications")
  String get _base => Endpoints.studentApplications;

  /// Resolve studId. If not provided, fallback to logged-in user.sId
  String? _resolveStudId(String? studId) => studId?.isNotEmpty == true ? studId : _app.user?.sId;

  @override
  Future<Either<APIException, StudentApplication?>> addApplication({
    required StudentApplication payload,
  }) async {
    try {
      // Ensure studId set from logged-in user if missing
      final effectivePayload = payload.studId?.isNotEmpty == true
          ? payload
          : payload.copyWith(studId: _app.user?.sId);

      final req = Request(
        method: RequestMethod.post,
        endpoint: _base, // "/applications"
        body: effectivePayload.toJson(), // dob -> ISO handled by model
      );

      final resp = await _network.request(req);
      final map = (resp.data as Map<String, dynamic>);
      final data = map['data'] as Map<String, dynamic>?;
      return Right(data == null ? null : StudentApplication.fromJson(data));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  Future<Either<APIException, List<StudentApplication>>> getAllApplications() async {
    try {
      final req = Request(
        method: RequestMethod.get,
        endpoint: _base, // "/applications"
      );
      final resp = await _network.request(req);
      final map = (resp.data as Map<String, dynamic>);
      final list = (map['data'] as List?) ?? const [];
      final apps = list
          .whereType<Map<String, dynamic>>()
          .map(StudentApplication.fromJson)
          .toList();
      return Right(apps);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  Future<Either<APIException, StudentApplication?>> getApplicationByStudId({
    String? studId,
  }) async {
    try {
      final id = _resolveStudId(studId);
      if (id == null || id.isEmpty) {
          return Left(APIException.from(e));
      }

      final req = Request(
        method: RequestMethod.get,
        endpoint: "$_base/$id", // "/applications/:studId"
      );
      final resp = await _network.request(req);
      final map = (resp.data as Map<String, dynamic>);
      final data = map['data'] as Map<String, dynamic>?;
      return Right(data == null ? null : StudentApplication.fromJson(data));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  Future<Either<APIException, StudentApplication?>> updateApplication({
    required StudentApplication payload,
    String? studId,
  }) async {
    try {
      final id = _resolveStudId(studId) ?? payload.studId;
      if (id == null || id.isEmpty) {
      
           return Left(APIException.from(e));
      }

      final req = Request(
        method: RequestMethod.put,
        endpoint: "$_base/$id", // "/applications/:studId"
        body: payload.copyWith(studId: id).toJson(), // ensure correct id in body
      );
      final resp = await _network.request(req);
      final map = (resp.data as Map<String, dynamic>);
      final data = map['data'] as Map<String, dynamic>?;
      return Right(data == null ? null : StudentApplication.fromJson(data));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  Future<Either<APIException, bool>> deleteApplication({
    String? studId,
  }) async {
    try {
      final id = _resolveStudId(studId);
      if (id == null || id.isEmpty) {
           return Left(APIException.from(e));
      }

      final req = Request(
        method: RequestMethod.delete,
        endpoint: "$_base/$id", // "/applications/:studId"
      );
      await _network.request(req);
      return const Right(true);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
