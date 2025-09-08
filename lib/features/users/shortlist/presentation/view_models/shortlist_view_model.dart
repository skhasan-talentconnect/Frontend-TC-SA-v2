import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/users/shortlist/data/data_source/data_source_impl.dart';

class ShortlistViewModel extends ViewStateProvider {
  final ShortlistDataSourceImpl _shortlistService = ShortlistDataSourceImpl();

  List<SchoolCardModel> _schools = getIt<AppStateProvider>().shortlistSchools;
  List<SchoolCardModel> get schools => _schools;
  set schools(List<SchoolCardModel> values) {
    _schools = values;
    notifyListeners();
  }

  Future<Failure?> addShortlist({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _shortlistService.addShortlist(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) async {
        failure = await getShortlist();
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getShortlist() async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await getIt<ShortlistDataSourceImpl>().getShortlist();

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) async {
        schools = res ?? [];
        getIt<AppStateProvider>().shortlistSchools = schools;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getShortlistCount() async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _shortlistService.getShortlistCount();

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> removeShortlist({required String schoolId}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _shortlistService.removeShortlist(schoolId: schoolId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) async {
        failure = await getShortlist();
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }
}
