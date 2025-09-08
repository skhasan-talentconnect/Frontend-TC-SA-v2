import 'package:tc_sa/common/index.dart' show UserPref, User;
import 'package:tc_sa/core/index.dart' show ResultFuture;

abstract class ProfileDataSource {
  ResultFuture<User?> getUserDetails();

  ResultFuture<User?> addProfile({
    required String name,
    required String email,
    required String phone,
    required String state,
    required String city,
    required String gender,
    required String dateOfBirth,
  });

  ResultFuture<User?> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String state,
    required String city,
    required String gender,
    required String dateOfBirth,
  });
}
