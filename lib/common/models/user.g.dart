// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  authId: json['authId'] as String?,
  email: json['email'] as String?,
  contactNo: json['contactNo'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  name: json['name'] as String?,
  gender: json['gender'] as String?,
  state: json['state'] as String?,
  city: json['city'] as String?,
  area: json['area'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  shortlistedSchools:
      (json['shortlistedSchools'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  userType: _$JsonConverterFromJson<String, UserType>(
    json['userType'],
    const UserTypeConverter().fromJson,
  ),
  sId: json['_id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  iV: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'authId': instance.authId,
  'email': instance.email,
  'contactNo': instance.contactNo,
  'dateOfBirth': instance.dateOfBirth,
  'name': instance.name,
  'gender': instance.gender,
  'state': instance.state,
  'city': instance.city,
  'area': instance.area,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'shortlistedSchools': instance.shortlistedSchools,
  'userType': _$JsonConverterToJson<String, UserType>(
    instance.userType,
    const UserTypeConverter().toJson,
  ),
  '_id': instance.sId,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.iV,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
