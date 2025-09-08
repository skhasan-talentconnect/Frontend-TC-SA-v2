import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/preferences/data/data_source/data_source_impl.dart';

class PrefViewModel extends ViewStateProvider {
  final PrefDataSourceImpl prefDataSourceImpl = PrefDataSourceImpl();

  Future<Failure?> addPreferences({
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await prefDataSourceImpl.addPreferences(
      boards: boards,
      interests: interests,
      preferredStandard: preferredStandard,
      schoolType: schoolType,
      shift: shift,
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        getIt<AppStateProvider>().userPref = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> updatePreferences({
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await prefDataSourceImpl.updatePreferences(
      boards: boards,
      interests: interests,
      preferredStandard: preferredStandard,
      schoolType: schoolType,
      shift: shift,
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        getIt<AppStateProvider>().userPref = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }
}
