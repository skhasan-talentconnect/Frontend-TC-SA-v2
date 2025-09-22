import 'package:dartz/dartz.dart';
import 'package:tc_sa/common/models/school_card_model.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/search/data/entities/search_query.dart';

import 'data_source.dart';

class SearchDataSourceImpl implements SearchDataSource {
  final _networkService = getIt<NetworkService>();

  @override
  ResultFuture<List<SchoolCardModel>> search({
    SearchQuery? query,
    required int page,
  }) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: Endpoints.adminSearch,
      queryParams: {
        if (query != null) 'search': query.query,
        if (query?.state != null) 'state': query?.state,
        if (query?.city != null) 'cities': query?.city,
        if (query?.board != null) 'board': query?.board,
        'limit': "10",
        'page': page.toString(),
      },
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data['data'] as List<dynamic>;

      if (response.isNotEmpty) {
        final schools =
            response.map((e) => SchoolCardModel.fromJson(e)).toList();
        return Right(schools);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right([]);
  }
}
