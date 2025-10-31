// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Photo _$PhotoFromJson(Map<String, dynamic> json) => _Photo(
  url: json['url'] as String?,
  publicId: json['publicId'] as String?,
  id: json['_id'] as String?,
  uploadedAt: json['uploadedAt'] as String?,
);

Map<String, dynamic> _$PhotoToJson(_Photo instance) => <String, dynamic>{
  'url': instance.url,
  'publicId': instance.publicId,
  '_id': instance.id,
  'uploadedAt': instance.uploadedAt,
};
