// lib/features/application/applications/data/data_source/application_data_source.dart
import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart' show APIException;
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';

abstract class ApplicationDataSource {
  Future<Either<APIException, StudentApplication?>> addApplication({
    required StudentApplication payload,
  });

  Future<Either<APIException, List<StudentApplication>>> getAllApplications();

  /// Return all applications for a given studId
  Future<Either<APIException, List<StudentApplication>>> getStudApplicationsByStudId({
    required String studId,
  });

  /// Get single application by its applicationId
  Future<Either<APIException, StudentApplication?>> getApplicationById({
    required String applicationId,
  });

  /// Update by applicationId
  Future<Either<APIException, StudentApplication?>> updateApplication({
    required String applicationId,
    required StudentApplication payload,
  });

  /// Delete by applicationId
  Future<Either<APIException, bool>> deleteApplication({
    required String applicationId,
  });
}
