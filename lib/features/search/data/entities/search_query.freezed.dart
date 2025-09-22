// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchQuery {

 String? get query; List<String>? get state; List<String>? get city; List<String>? get board; List<String>? get genderType;// ✅ NEW
 List<String>? get schoolMode;// ✅ NEW
 List<String>? get feeRange;
/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryCopyWith<SearchQuery> get copyWith => _$SearchQueryCopyWithImpl<SearchQuery>(this as SearchQuery, _$identity);

  /// Serializes this SearchQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQuery&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.state, state)&&const DeepCollectionEquality().equals(other.city, city)&&const DeepCollectionEquality().equals(other.board, board)&&const DeepCollectionEquality().equals(other.genderType, genderType)&&const DeepCollectionEquality().equals(other.schoolMode, schoolMode)&&const DeepCollectionEquality().equals(other.feeRange, feeRange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(state),const DeepCollectionEquality().hash(city),const DeepCollectionEquality().hash(board),const DeepCollectionEquality().hash(genderType),const DeepCollectionEquality().hash(schoolMode),const DeepCollectionEquality().hash(feeRange));

@override
String toString() {
  return 'SearchQuery(query: $query, state: $state, city: $city, board: $board, genderType: $genderType, schoolMode: $schoolMode, feeRange: $feeRange)';
}


}

/// @nodoc
abstract mixin class $SearchQueryCopyWith<$Res>  {
  factory $SearchQueryCopyWith(SearchQuery value, $Res Function(SearchQuery) _then) = _$SearchQueryCopyWithImpl;
@useResult
$Res call({
 String? query, List<String>? state, List<String>? city, List<String>? board, List<String>? genderType, List<String>? schoolMode, List<String>? feeRange
});




}
/// @nodoc
class _$SearchQueryCopyWithImpl<$Res>
    implements $SearchQueryCopyWith<$Res> {
  _$SearchQueryCopyWithImpl(this._self, this._then);

  final SearchQuery _self;
  final $Res Function(SearchQuery) _then;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = freezed,Object? state = freezed,Object? city = freezed,Object? board = freezed,Object? genderType = freezed,Object? schoolMode = freezed,Object? feeRange = freezed,}) {
  return _then(_self.copyWith(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as List<String>?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as List<String>?,board: freezed == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as List<String>?,genderType: freezed == genderType ? _self.genderType : genderType // ignore: cast_nullable_to_non_nullable
as List<String>?,schoolMode: freezed == schoolMode ? _self.schoolMode : schoolMode // ignore: cast_nullable_to_non_nullable
as List<String>?,feeRange: freezed == feeRange ? _self.feeRange : feeRange // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchQuery].
extension SearchQueryPatterns on SearchQuery {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchQuery value)  $default,){
final _that = this;
switch (_that) {
case _SearchQuery():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchQuery value)?  $default,){
final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? query,  List<String>? state,  List<String>? city,  List<String>? board,  List<String>? genderType,  List<String>? schoolMode,  List<String>? feeRange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
return $default(_that.query,_that.state,_that.city,_that.board,_that.genderType,_that.schoolMode,_that.feeRange);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? query,  List<String>? state,  List<String>? city,  List<String>? board,  List<String>? genderType,  List<String>? schoolMode,  List<String>? feeRange)  $default,) {final _that = this;
switch (_that) {
case _SearchQuery():
return $default(_that.query,_that.state,_that.city,_that.board,_that.genderType,_that.schoolMode,_that.feeRange);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? query,  List<String>? state,  List<String>? city,  List<String>? board,  List<String>? genderType,  List<String>? schoolMode,  List<String>? feeRange)?  $default,) {final _that = this;
switch (_that) {
case _SearchQuery() when $default != null:
return $default(_that.query,_that.state,_that.city,_that.board,_that.genderType,_that.schoolMode,_that.feeRange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchQuery implements SearchQuery {
  const _SearchQuery({this.query, final  List<String>? state, final  List<String>? city, final  List<String>? board, final  List<String>? genderType, final  List<String>? schoolMode, final  List<String>? feeRange}): _state = state,_city = city,_board = board,_genderType = genderType,_schoolMode = schoolMode,_feeRange = feeRange;
  factory _SearchQuery.fromJson(Map<String, dynamic> json) => _$SearchQueryFromJson(json);

@override final  String? query;
 final  List<String>? _state;
@override List<String>? get state {
  final value = _state;
  if (value == null) return null;
  if (_state is EqualUnmodifiableListView) return _state;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _city;
@override List<String>? get city {
  final value = _city;
  if (value == null) return null;
  if (_city is EqualUnmodifiableListView) return _city;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _board;
@override List<String>? get board {
  final value = _board;
  if (value == null) return null;
  if (_board is EqualUnmodifiableListView) return _board;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _genderType;
@override List<String>? get genderType {
  final value = _genderType;
  if (value == null) return null;
  if (_genderType is EqualUnmodifiableListView) return _genderType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// ✅ NEW
 final  List<String>? _schoolMode;
// ✅ NEW
@override List<String>? get schoolMode {
  final value = _schoolMode;
  if (value == null) return null;
  if (_schoolMode is EqualUnmodifiableListView) return _schoolMode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// ✅ NEW
 final  List<String>? _feeRange;
// ✅ NEW
@override List<String>? get feeRange {
  final value = _feeRange;
  if (value == null) return null;
  if (_feeRange is EqualUnmodifiableListView) return _feeRange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQueryCopyWith<_SearchQuery> get copyWith => __$SearchQueryCopyWithImpl<_SearchQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQuery&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._state, _state)&&const DeepCollectionEquality().equals(other._city, _city)&&const DeepCollectionEquality().equals(other._board, _board)&&const DeepCollectionEquality().equals(other._genderType, _genderType)&&const DeepCollectionEquality().equals(other._schoolMode, _schoolMode)&&const DeepCollectionEquality().equals(other._feeRange, _feeRange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_state),const DeepCollectionEquality().hash(_city),const DeepCollectionEquality().hash(_board),const DeepCollectionEquality().hash(_genderType),const DeepCollectionEquality().hash(_schoolMode),const DeepCollectionEquality().hash(_feeRange));

@override
String toString() {
  return 'SearchQuery(query: $query, state: $state, city: $city, board: $board, genderType: $genderType, schoolMode: $schoolMode, feeRange: $feeRange)';
}


}

/// @nodoc
abstract mixin class _$SearchQueryCopyWith<$Res> implements $SearchQueryCopyWith<$Res> {
  factory _$SearchQueryCopyWith(_SearchQuery value, $Res Function(_SearchQuery) _then) = __$SearchQueryCopyWithImpl;
@override @useResult
$Res call({
 String? query, List<String>? state, List<String>? city, List<String>? board, List<String>? genderType, List<String>? schoolMode, List<String>? feeRange
});




}
/// @nodoc
class __$SearchQueryCopyWithImpl<$Res>
    implements _$SearchQueryCopyWith<$Res> {
  __$SearchQueryCopyWithImpl(this._self, this._then);

  final _SearchQuery _self;
  final $Res Function(_SearchQuery) _then;

/// Create a copy of SearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = freezed,Object? state = freezed,Object? city = freezed,Object? board = freezed,Object? genderType = freezed,Object? schoolMode = freezed,Object? feeRange = freezed,}) {
  return _then(_SearchQuery(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self._state : state // ignore: cast_nullable_to_non_nullable
as List<String>?,city: freezed == city ? _self._city : city // ignore: cast_nullable_to_non_nullable
as List<String>?,board: freezed == board ? _self._board : board // ignore: cast_nullable_to_non_nullable
as List<String>?,genderType: freezed == genderType ? _self._genderType : genderType // ignore: cast_nullable_to_non_nullable
as List<String>?,schoolMode: freezed == schoolMode ? _self._schoolMode : schoolMode // ignore: cast_nullable_to_non_nullable
as List<String>?,feeRange: freezed == feeRange ? _self._feeRange : feeRange // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
