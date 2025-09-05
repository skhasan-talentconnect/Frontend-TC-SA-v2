
import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/detailPages/alumini/data/entities/alumini_model.dart';

abstract class AbstractAlumniService {
  ResultFuture<AlumniModel?> addAlumni({
    required String schoolId,
    required List<AlumniScoreItem> topAlumnis,
    required List<FamousAlumniItem> famousAlumnies,
    required List<AlumniScoreItem> alumnis,
  });

  ResultFuture<AlumniModel?> getAlumniBySchool({required String schoolId});

  ResultFuture<AlumniModel?> updateAlumniBySchool({
    required String schoolId,
    List<AlumniScoreItem>? topAlumnis,
    List<FamousAlumniItem>? famousAlumnies,
    List<AlumniScoreItem>? alumnis,
  });

  ResultFuture<String?> deleteAlumniBySchool({required String schoolId});
}
