import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart' show ResultFuture, APIException;
import 'package:tc_sa/features/school/school_info/school_model.dart';

abstract class PredictorDataSource {
  /// Predicts schools based on the provided filters
  /// Returns either an APIException or a list of predicted SchoolModel objects
  ResultFuture<List<SchoolModel>?> predictSchools(
    Map<String, dynamic> filters,
  );
}