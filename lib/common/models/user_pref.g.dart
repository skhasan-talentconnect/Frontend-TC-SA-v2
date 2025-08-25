// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPref _$UserPrefFromJson(Map<String, dynamic> json) => _UserPref(
  sId: json['sId'] as String?,
  studentId: json['studentId'] as String?,
  state: json['state'] as String?,
  city: json['city'] as String?,
  boards: json['boards'] as String?,
  preferredStandard: json['preferredStandard'] as String?,
  interests: json['interests'] as String?,
  schoolType: json['schoolType'] as String?,
  shift: json['shift'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  iV: (json['iV'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserPrefToJson(_UserPref instance) => <String, dynamic>{
  'sId': instance.sId,
  'studentId': instance.studentId,
  'state': instance.state,
  'city': instance.city,
  'boards': instance.boards,
  'preferredStandard': instance.preferredStandard,
  'interests': instance.interests,
  'schoolType': instance.schoolType,
  'shift': instance.shift,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'iV': instance.iV,
};
