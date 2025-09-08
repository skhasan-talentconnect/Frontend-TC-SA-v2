// features/compare/data/data_source/data_source.dart
import 'package:tc_sa/core/network/typedef.dart';

import '../entities/school_compare_model.dart' show SchoolCompareModel;

abstract class CompareDataSource {
  ResultFuture<Map<String, SchoolCompareModel>?> compareSchools({
    required String schoolId1,
    required String schoolId2,
  });
}
