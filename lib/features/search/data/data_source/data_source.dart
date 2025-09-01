import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/search/data/entities/search_query.dart';

abstract class SearchDataSource {
  ResultFuture<List<SchoolCardModel>> search({
    required int page,
    SearchQuery? query,
  });
}
