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
  shortlistedSchools:
      (json['shortlistedSchools'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  userType: json['userType'] as String?,
  sId: json['sId'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  iV: (json['iV'] as num?)?.toInt(),
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
  'shortlistedSchools': instance.shortlistedSchools,
  'userType': instance.userType,
  'sId': instance.sId,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'iV': instance.iV,
};
