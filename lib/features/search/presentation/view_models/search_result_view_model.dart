import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/search/data/entities/search_query.dart';

import '../../data/data_source/data_source_impl.dart';

class SearchResultViewModel extends ViewStateProvider {
  final _searchDataSource = SearchDataSourceImpl();

  List<SchoolCardModel> _schools = [];
  List<SchoolCardModel> get schools => _schools;
  set schools(List<SchoolCardModel> value) {
    if (value.isEmpty) {
      _schools = [];
    } else {
      _schools = [..._schools, ...value];
    }
    notifyListeners();
  }

  int _page = 1;
  int get page => _page;
  void incrementPage() {
    _page += 1;
    notifyListeners();
  }

  bool _isLoadingSchools = false;
  bool get isLoadingSchools => _isLoadingSchools;
  set isLoadingSchools(bool value) {
    _isLoadingSchools = value;
    notifyListeners();
  }

  bool _isMoreSchoolsAvailable = true;
  bool get isMoreSchoolsAvailable => _isMoreSchoolsAvailable;
  set isMoreSchoolsAvailable(bool value) {
    _isMoreSchoolsAvailable = value;
    notifyListeners();
  }

  Future<Failure?> searchSchools({
    SearchQuery? query,
    bool notify = false,
  }) async {
    notify ? setViewState(ViewState.busy) : isLoadingSchools = true;

    if (notify) {
      _page = 1;
      isMoreSchoolsAvailable = false;
      schools = [];
    }

    Failure? failure;

    final result = await _searchDataSource.search(query: query, page: page);
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        schools = res;

        if (res.isEmpty) {
          isMoreSchoolsAvailable = false;
          return;
        }

        incrementPage();
      },
    );

    notify ? setViewState(ViewState.complete) : isLoadingSchools = false;
    return failure;
  }
}
