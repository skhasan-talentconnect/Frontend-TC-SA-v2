import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import '../entities/infrastructure_model.dart';

abstract class AbstractInfrastructureService {
  ResultFuture<InfrastructureModel?> getInfrastructureBySchoolId({
    required String schoolId,
  });

  ResultFuture<InfrastructureModel?> addInfrastructure({
    required String schoolId,
    required List<String> labs,
    required List<String> sportsGrounds,
    required int libraryBooks,
    required int smartClassrooms,
  });

  ResultFuture<InfrastructureModel?> updateInfrastructure({
    required String schoolId,
    List<String>? labs,
    List<String>? sportsGrounds,
    int? libraryBooks,
    int? smartClassrooms,
  });
}