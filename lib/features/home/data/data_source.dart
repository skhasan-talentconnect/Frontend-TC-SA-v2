import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

abstract class SchoolDataSource {
  ResultFuture<List<SchoolCardModel>> getSchools({
    Map<String, dynamic> filters,
  });
}
