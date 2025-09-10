import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart' show APIException;
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';

abstract class ApplicationDataSource {
  /// POST /applications
  Future<Either<APIException, StudentApplication?>> addApplication({
    required StudentApplication payload,
  });

  /// GET /applications
  Future<Either<APIException, List<StudentApplication>>> getAllApplications();

  /// GET /applications/:studId
  Future<Either<APIException, StudentApplication?>> getApplicationByStudId({
    String? studId,
  });

  /// PUT /applications/:studId
  Future<Either<APIException, StudentApplication?>> updateApplication({
    required StudentApplication payload,
    String? studId,
  });

  /// DELETE /applications/:studId
  Future<Either<APIException, bool>> deleteApplication({
    String? studId,
  });
}
