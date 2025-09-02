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
      notificationType: json['notificationType'] as String?,
      isRead: json['is_read'] as bool?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$NotificationToJson(_Notification instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'authId': instance.authId,
      'title': instance.title,
      'body': instance.body,
      'path': instance.path,
      'notificationType': instance.notificationType,
      'is_read': instance.isRead,
      'data': instance.data,
    };
