// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SchoolCardModel _$SchoolCardModelFromJson(
  Map<String, dynamic> json,
) => _SchoolCardModel(
  schoolId: json['schoolId'] as String?,
  ratings: (json['ratings'] as num?)?.toInt(),
  name: json['name'] as String?,
  feeRange: json['feeRange'] as String?,
  area: json['area'] as String?,
  location: json['location'] as String?,
  board: json['board'] as String?,
  genderType: json['genderType'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  shifts: (json['shifts'] as List<dynamic>?)?.map((e) => e as String).toList(),
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList(),
  schoolMode: json['schoolMode'] as String?,
);

Map<String, dynamic> _$SchoolCardModelToJson(_SchoolCardModel instance) =>
    <String, dynamic>{
      'schoolId': instance.schoolId,
      'ratings': instance.ratings,
      'name': instance.name,
      'feeRange': instance.feeRange,
      'area': instance.area,
      'location': instance.location,
      'board': instance.board,
      'genderType': instance.genderType,
      'score': instance.score,
      'shifts': instance.shifts,
      'amenities': instance.amenities,
      'schoolMode': instance.schoolMode,
    };
