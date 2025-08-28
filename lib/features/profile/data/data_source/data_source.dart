import 'package:tc_sa/common/index.dart' show UserPref, User;
import 'package:tc_sa/core/index.dart' show ResultFuture;

abstract class ProfileDataSource {
  ResultFuture<User?> getUserDetails({required String authId});

  ResultFuture<UserPref?> getUserPreferences({required String studId});
}
