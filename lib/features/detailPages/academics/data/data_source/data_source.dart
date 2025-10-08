import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import '../entities/academics_model.dart';

abstract class AbstractAcademicsService {
  ResultFuture<AcademicsModel?> getAcademicsBySchoolId({
    required String schoolId,
  });
}