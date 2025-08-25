import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_pref.freezed.dart';
part 'user_pref.g.dart';

@freezed
abstract class UserPref with _$UserPref {
  const factory UserPref({
    String? sId,
    String? studentId,
    String? state,
    String? city,
    String? boards,
    String? preferredStandard,
    String? interests,
    String? schoolType,
    String? shift,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) = _UserPref;

  factory UserPref.fromJson(Map<String, dynamic> json) =>
      _$UserPrefFromJson(json);
}
