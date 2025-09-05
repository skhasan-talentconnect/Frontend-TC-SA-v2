// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Notification _$NotificationFromJson(Map<String, dynamic> json) =>
    _Notification(
      sId: json['_id'] as String?,
      authId: json['authId'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      path: json['path'] as String?,
      notificationType: _$JsonConverterFromJson<String, NotificationType>(
        json['notificationType'],
        const NotificationTypeConverter().fromJson,
      ),
      isRead: json['is_read'] as bool?,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(_Notification instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'authId': instance.authId,
      'title': instance.title,
      'body': instance.body,
      'path': instance.path,
      'notificationType': _$JsonConverterToJson<String, NotificationType>(
        instance.notificationType,
        const NotificationTypeConverter().toJson,
      ),
      'is_read': instance.isRead,
      'data': instance.data,
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
