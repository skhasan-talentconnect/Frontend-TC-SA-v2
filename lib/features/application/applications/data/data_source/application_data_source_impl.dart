// lib/features/application/applications/data/data_source/application_data_source_impl.dart
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

  // Use the base URL provided
  String get _base => 'https://backend-tc-sa-v2.onrender.com/api/applications';

  String? _resolveStudId(String? studId) =>
      (studId != null && studId.isNotEmpty) ? studId : _app.user?.sId;

  @override
  Future<Either<APIException, StudentApplication?>> addApplication({
    required StudentApplication payload,
  }) async {
    try {
      final effectivePayload = payload.studId?.isNotEmpty == true
          ? payload
          : payload.copyWith(studId: _app.user?.sId);

      final req = Request(
        method: RequestMethod.post,
        endpoint: "$_base/",
        body: effectivePayload.toJson(),
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
        endpoint: _base,
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
  Future<Either<APIException, List<StudentApplication>>> getStudApplicationsByStudId({
    required String studId,
  }) async {
    try {
      final id = _resolveStudId(studId) ?? studId;
      if (id == null || id.isEmpty) {
        return Left(APIException.from("Missing studId"));
      }
      final req = Request(
        method: RequestMethod.get,
        endpoint: "$_base/stud/$id",
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
  Future<Either<APIException, StudentApplication?>> getApplicationById({
    required String applicationId,
  }) async {
    try {
      if (applicationId.isEmpty) return Left(APIException.from("Missing applicationId"));
      final req = Request(
        method: RequestMethod.get,
        endpoint: "$_base/$applicationId",
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
    required String applicationId,
    required StudentApplication payload,
  }) async {
    try {
      if (applicationId.isEmpty) return Left(APIException.from("Missing applicationId"));
      final req = Request(
        method: RequestMethod.put,
        endpoint: "$_base/$applicationId",
        body: payload.toJson(),
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
    required String applicationId,
  }) async {
    try {
      if (applicationId.isEmpty) return Left(APIException.from("Missing applicationId"));
      final req = Request(
        method: RequestMethod.delete,
        endpoint: "$_base/$applicationId",
      );
      await _network.request(req);
      return const Right(true);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
