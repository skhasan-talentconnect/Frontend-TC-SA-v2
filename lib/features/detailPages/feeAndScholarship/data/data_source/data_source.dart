
import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/data/entities/feeAndScholarship_model.dart';

abstract class AbstractFeesAndScholarshipsService {
  ResultFuture<FeesAndScholarshipsModel?> getFeesAndScholarshipsBySchoolId({
    required String schoolId,
  });
}