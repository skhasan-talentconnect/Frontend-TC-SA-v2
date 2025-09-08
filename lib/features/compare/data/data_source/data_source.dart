// features/compare/data/data_source/data_source.dart
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/network/typedef.dart';

abstract class CompareDataSource {
  ResultFuture<Map<String, dynamic>> compareSchools({
    required String schoolId1,
    required String schoolId2,
  });
}
