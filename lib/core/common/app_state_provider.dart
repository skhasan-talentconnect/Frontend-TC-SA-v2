import 'dart:developer';

import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/auth/authentication/data/entities/auth_model.dart';
import 'package:tc_sa/features/preferences/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';
// Added import for the PDF VM
import 'package:tc_sa/features/application/pdfModule/presentation/view_models/pdf_view_model.dart';

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

  bool get isGuest => user?.userType == UserType.guest;

  bool get isProfileComplete =>
      user != null && authModel != null && userPref != null;

  bool get isAuthComplete => authModel != null;

  bool get isProfileRemaining => user == null && authModel != null;

  bool get isPrefRemaining =>
      user != null && authModel != null && userPref == null;

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
        log(res?.toJson().toString() ?? '');
        user = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getUserPrefDetails() async {
    setViewState(ViewState.busy);

    Failure? failure;
    final result = await getIt<PrefDataSourceImpl>().getPreferences();

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

  /// Ensure StudentPdfViewModel is registered in GetIt.
  /// If not registered, register a lazy singleton so calls to getIt<StudentPdfViewModel>()
  /// won't throw. Update registration if the view model later requires deps.
  void ensureStudentPdfViewModelRegistered() {
    try {
      if (!getIt.isRegistered<StudentPdfViewModel>()) {
        getIt.registerLazySingleton<StudentPdfViewModel>(
          () => StudentPdfViewModel(),
        );
      }
    } catch (e) {
      // avoid crashing on hot-reload duplicate registrations; log for debugging
      log('ensureStudentPdfViewModelRegistered error: $e');
    }
  }

  Future<void> loadAllUserData() async {
    try {
      setViewState(ViewState.busy);

      print("🚀 Loading user details...");
      await getUserDetails();

      print("📚 Loading user preferences...");
      await getUserPrefDetails();

      print("✅ All user data loaded successfully");

      // ensure StudentPdfViewModel registration so consumers can safely call getIt<StudentPdfViewModel>()
      try {
        ensureStudentPdfViewModelRegistered();
      } catch (e) {
        log('Failed to register StudentPdfViewModel: $e');
      }
    } catch (e) {
      print("❌ Error loading user data: $e");
    } finally {
      setViewState(ViewState.complete);
    }
  }
}
