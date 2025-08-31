// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => _AuthModel(
  sId: json['_id'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
  isEmailVerified: json['isEmailVerified'] as bool?,
  userType: json['userType'] as String?,
  authProvider: json['authProvider'] as String?,
  deviceToken: json['deviceToken'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  iV: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthModelToJson(_AuthModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'email': instance.email,
      'password': instance.password,
      'isEmailVerified': instance.isEmailVerified,
      'userType': instance.userType,
      'authProvider': instance.authProvider,
      'deviceToken': instance.deviceToken,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.iV,
    };
