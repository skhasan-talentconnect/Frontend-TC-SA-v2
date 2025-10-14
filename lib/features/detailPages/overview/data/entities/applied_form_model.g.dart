// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppliedFormModel _$AppliedFormModelFromJson(Map<String, dynamic> json) =>
    _AppliedFormModel(
      formId: json['formId'] as String?,
      isApplied: json['isApplied'] as bool?,
      status: _$JsonConverterFromJson<String, FormStatus>(
        json['status'],
        const FormStatusConverter().fromJson,
      ),
    );

Map<String, dynamic> _$AppliedFormModelToJson(_AppliedFormModel instance) =>
    <String, dynamic>{
      'formId': instance.formId,
      'isApplied': instance.isApplied,
      'status': _$JsonConverterToJson<String, FormStatus>(
        instance.status,
        const FormStatusConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
