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
  interviewNote: json['interviewNote'] as String?,
  status: _$JsonConverterFromJson<String, FormStatus>(
    json['status'],
    const FormStatusConverter().fromJson,
  ),
  application:
      json['applicationId'] == null
          ? null
          : StudentApplication.fromJson(
            json['applicationId'] as Map<String, dynamic>,
          ),
  iV: (json['__v'] as num?)?.toInt(),
  amount: (json['amount'] as num?)?.toInt(),
  payment: _$JsonConverterFromJson<String, PaymentStatus>(
    json['payment'],
    const StringOrPaymentStatusConverter().fromJson,
  ),
  paymentInfo:
      json['paymentInfo'] == null
          ? null
          : Payment.fromJson(json['paymentInfo'] as Map<String, dynamic>),
  createdAt: const DateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const DateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$FormToJson(_Form instance) => <String, dynamic>{
  '_id': instance.sId,
  'schoolId': instance.school,
  'studId': instance.user,
  'interviewNote': instance.interviewNote,
  'status': _$JsonConverterToJson<String, FormStatus>(
    instance.status,
    const FormStatusConverter().toJson,
  ),
  'applicationId': instance.application,
  '__v': instance.iV,
  'amount': instance.amount,
  'payment': _$JsonConverterToJson<String, PaymentStatus>(
    instance.payment,
    const StringOrPaymentStatusConverter().toJson,
  ),
  'paymentInfo': instance.paymentInfo,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
