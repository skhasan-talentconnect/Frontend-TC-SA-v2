import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/data/entities/auth_model.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';

class AppStateProvider extends ViewStateProvider {
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

  Future<Failure?> getUserDetails() async {
    Failure? failure;
    final result = await getIt<ProfileDataSourceImpl>().getUserDetails(
      authId: _authModel?.sId ?? '',
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        user = res;
      },
    );

    return failure;
  }
}
