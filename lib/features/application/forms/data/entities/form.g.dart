// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Form _$FormFromJson(Map<String, dynamic> json) => _Form(
  sId: json['_id'] as String?,
  school:
      json['schoolId'] == null
          ? null
          : SchoolModel.fromJson(json['schoolId'] as Map<String, dynamic>),
  user:
      json['studId'] == null
          ? null
          : User.fromJson(json['studId'] as Map<String, dynamic>),
  status: _$JsonConverterFromJson<String, FormStatus>(
    json['status'],
    const FormStatusConverter().fromJson,
  ),
  iV: (json['__v'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$FormToJson(_Form instance) => <String, dynamic>{
  '_id': instance.sId,
  'schoolId': instance.school,
  'studId': instance.user,
  'status': _$JsonConverterToJson<String, FormStatus>(
    instance.status,
    const FormStatusConverter().toJson,
  ),
  '__v': instance.iV,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
