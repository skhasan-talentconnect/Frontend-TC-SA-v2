// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) => _SearchQuery(
  query: json['query'] as String?,
  state: (json['state'] as List<dynamic>?)?.map((e) => e as String).toList(),
  city: (json['city'] as List<dynamic>?)?.map((e) => e as String).toList(),
  board: (json['board'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$SearchQueryToJson(_SearchQuery instance) =>
    <String, dynamic>{
      'query': instance.query,
      'state': instance.state,
      'city': instance.city,
      'board': instance.board,
    };
