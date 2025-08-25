import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class AuthModel with _$AuthModel {
  const factory AuthModel({
    String? sId,
    String? email,
    String? password,
    bool? isEmailVerified,
    String? userType,
    String? authProvider,
    String? deviceToken,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
