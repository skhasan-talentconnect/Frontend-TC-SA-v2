import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/faculty/data/entities/faculty-model.dart';


abstract class AbstractFacultyService {
  ResultFuture<FacultyModel?> getFacultyBySchoolId({
    required String schoolId,
  });
}