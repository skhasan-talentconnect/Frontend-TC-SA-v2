import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/auth/authentication/data/entities/auth_model.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';

class AppStateProvider extends ViewStateProvider {
  String get userEmail => user?.email ?? authModel?.email ?? '';

  AuthModel? _authModel;
  AuthModel? get authModel => _authModel;
  set authModel(AuthModel? auth) {
    _authModel = auth;
    notifyListeners();
  }

  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  UserPref? _userPref;
  UserPref? get userPref => _userPref;
  set userPref(UserPref? user) {
    _userPref = user;
    notifyListeners();
  }

  List<SchoolCardModel> _shortlistSchools = [];
  List<SchoolCardModel> get shortlistSchools => _shortlistSchools;
  set shortlistSchools(List<SchoolCardModel> values) {
    _shortlistSchools = values;
    notifyListeners();
  }

  bool isSaved(String? schoolId) {
    for (SchoolCardModel school in shortlistSchools) {
      if (school.schoolId == schoolId) {
        return true;
      }
    }

    return false;
  }

  Future<Failure?> getAuthDetails() async {
    setViewState(ViewState.busy);

    Failure? failure;
    final result = await getIt<AuthDataSourceImpl>().getAuth();

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        authModel = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getUserDetails() async {
    setViewState(ViewState.busy);

    Failure? failure;
    final result = await getIt<ProfileDataSourceImpl>().getUserDetails();

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        user = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getUserPrefDetails() async {
    setViewState(ViewState.busy);

    Failure? failure;
    final result = await getIt<ProfileDataSourceImpl>().getUserPreferences();

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        userPref = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }
}
