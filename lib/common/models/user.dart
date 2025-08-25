import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    String? authId,
    String? email,
    String? contactNo,
    String? dateOfBirth,
    String? name,
    String? gender,
    String? state,
    String? city,
    List<String>? shortlistedSchools,
    String? userType,
    String? sId,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
