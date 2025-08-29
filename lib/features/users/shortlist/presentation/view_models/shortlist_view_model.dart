import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/users/shortlist/data/data_source/data_source_impl.dart';


class ShortlistViewModel extends ViewStateProvider {
  final ShortlistDataSourceImpl _shortlistService = ShortlistDataSourceImpl();

  Future<Failure?> addShortlist({
    required String schoolId,
    required String authId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);
    final result = await _shortlistService.addShortlist(
      authId: authId,
      schoolId: schoolId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getShortlist({required String authId}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _shortlistService.getShortlist(authId: authId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getShortlistCount({required String authId}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _shortlistService.getShortlistCount(authId: authId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> removeShortlist({
    required String authId,
    required String schoolId,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _shortlistService.removeShortlist(
      authId: authId,
      schoolId: schoolId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
