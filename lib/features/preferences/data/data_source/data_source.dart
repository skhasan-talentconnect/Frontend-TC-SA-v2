import 'package:tc_sa/common/index.dart' show UserPref;
import 'package:tc_sa/core/index.dart' show ResultFuture;

abstract class PrefDataSource {
  ResultFuture<UserPref?> addPreferences({
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  });

  ResultFuture<UserPref?> updatePreferences({
    required String boards,
    required String preferredStandard,
    required String interests,
    required String schoolType,
    required String shift,
  });

  ResultFuture<UserPref?> getPreferences();
}
