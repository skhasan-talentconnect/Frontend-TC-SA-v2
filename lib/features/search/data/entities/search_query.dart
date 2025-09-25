import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_query.freezed.dart';
part 'search_query.g.dart';

@freezed
abstract class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    String? query,
    List<String>? state,
    List<String>? city,
    List<String>? board,
     List<String>? genderType,   // ✅ NEW
    List<String>? schoolMode,   // ✅ NEW
   List<String>?  feeRange,      
  }) = _SearchQuery;

  factory SearchQuery.fromJson(Map<String, Object?> json) =>
      _$SearchQueryFromJson(json);
}
