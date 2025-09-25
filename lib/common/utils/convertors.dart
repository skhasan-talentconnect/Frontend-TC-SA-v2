import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/core/utils/enums.dart';

class UserTypeConverter implements JsonConverter<UserType, String> {
  const UserTypeConverter();

  @override
  UserType fromJson(String json) {
    return UserTypeExt.fromValue(json);
  }

  @override
  String toJson(UserType object) {
    return object.label;
  }
}
