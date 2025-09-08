// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_compare_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SchoolCompareModel _$SchoolCompareModelFromJson(
  Map<String, dynamic> json,
) => _SchoolCompareModel(
  name: json['name'] as String,
  board: json['board'] as String,
  feeRange: json['feeRange'] as String,
  schoolMode: json['schoolMode'] as String,
  shifts: (json['shifts'] as List<dynamic>).map((e) => e as String).toList(),
  predefinedAmenities:
      (json['predefinedAmenities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  activities:
      (json['activities'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$SchoolCompareModelToJson(_SchoolCompareModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'board': instance.board,
      'feeRange': instance.feeRange,
      'schoolMode': instance.schoolMode,
      'shifts': instance.shifts,
      'predefinedAmenities': instance.predefinedAmenities,
      'activities': instance.activities,
    };
