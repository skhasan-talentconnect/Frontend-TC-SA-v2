
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/home/data/data_source_impl.dart';

class SchoolViewModel extends ViewStateProvider {
  final _schoolDataSource = SchoolDataSourceImpl();

  List<SchoolCardModel> _boardSchools = [];
  List<SchoolCardModel> get boardSchools => _boardSchools;
  set boardSchools(List<SchoolCardModel> value) {
    _boardSchools = value;
    notifyListeners();
  }

   List<SchoolCardModel> _nearbySchools = [];
  List<SchoolCardModel> get nearbySchools => _nearbySchools;
  set nearbySchools(List<SchoolCardModel> value) {
    _nearbySchools = value;
    notifyListeners();
  }

  List<SchoolCardModel> _stateSchools = [];
  List<SchoolCardModel> get stateSchools => _stateSchools;
  set stateSchools(List<SchoolCardModel> value) {
    _stateSchools = value;
    notifyListeners();
  }

  List<SchoolCardModel> _citySchools = [];
  List<SchoolCardModel> get citySchools => _citySchools;
  set citySchools(List<SchoolCardModel> value) {
    _citySchools = value;
    notifyListeners();
  }

  Future<Failure?> getBoardsSchools() async {
    setViewState(ViewState.busy);

    Failure? failure;

    final result = await _schoolDataSource.getSchools(
      filters: {'board': getIt<AppStateProvider>().userPref?.boards},
    );
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        boardSchools = res;
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getStateSchools() async {
    setViewState(ViewState.busy);

    Failure? failure;

    final result = await _schoolDataSource.getSchools(
      filters: {'state': getIt<AppStateProvider>().user?.state},
    );
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        stateSchools = res;
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getCitySchools() async {
    setViewState(ViewState.busy);

    Failure? failure;

    final result = await _schoolDataSource.getSchools(
      filters: {'city': getIt<AppStateProvider>().user?.city},
    );
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        citySchools = res;
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }
Future<Failure?> getNearbySchools() async {
    setViewState(ViewState.busy);
    Failure? failure;

    final user = getIt<AppStateProvider>().user;

    // Ensure we have all the necessary data from the user model
    if (user?.latitude == null || user?.longitude == null || user?.state == null) {
      setViewState(ViewState.complete);
      // Silently fail if location data is missing, or return a specific failure
      return null; 
    }

    final result = await _schoolDataSource.getNearbySchools(
      latitude: user!.latitude!,
      longitude: user.longitude!,
      state: user.state!,
    );
    
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        nearbySchools = res;
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }
}