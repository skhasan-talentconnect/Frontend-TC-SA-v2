// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SchoolCardModel {

 String? get schoolId; int? get ratings; String? get name; String? get feeRange; String? get area; String? get location; String? get board; String? get genderType; List<String>? get shifts; List<String>? get amenities; String? get schoolMode;
/// Create a copy of SchoolCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolCardModelCopyWith<SchoolCardModel> get copyWith => _$SchoolCardModelCopyWithImpl<SchoolCardModel>(this as SchoolCardModel, _$identity);

  /// Serializes this SchoolCardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolCardModel&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.ratings, ratings) || other.ratings == ratings)&&(identical(other.name, name) || other.name == name)&&(identical(other.feeRange, feeRange) || other.feeRange == feeRange)&&(identical(other.area, area) || other.area == area)&&(identical(other.location, location) || other.location == location)&&(identical(other.board, board) || other.board == board)&&(identical(other.genderType, genderType) || other.genderType == genderType)&&const DeepCollectionEquality().equals(other.shifts, shifts)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&(identical(other.schoolMode, schoolMode) || other.schoolMode == schoolMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schoolId,ratings,name,feeRange,area,location,board,genderType,const DeepCollectionEquality().hash(shifts),const DeepCollectionEquality().hash(amenities),schoolMode);

@override
String toString() {
  return 'SchoolCardModel(schoolId: $schoolId, ratings: $ratings, name: $name, feeRange: $feeRange, area: $area, location: $location, board: $board, genderType: $genderType, shifts: $shifts, amenities: $amenities, schoolMode: $schoolMode)';
}


}

/// @nodoc
abstract mixin class $SchoolCardModelCopyWith<$Res>  {
  factory $SchoolCardModelCopyWith(SchoolCardModel value, $Res Function(SchoolCardModel) _then) = _$SchoolCardModelCopyWithImpl;
@useResult
$Res call({
 String? schoolId, int? ratings, String? name, String? feeRange, String? area, String? location, String? board, String? genderType, List<String>? shifts, List<String>? amenities, String? schoolMode
});




}
/// @nodoc
class _$SchoolCardModelCopyWithImpl<$Res>
    implements $SchoolCardModelCopyWith<$Res> {
  _$SchoolCardModelCopyWithImpl(this._self, this._then);

  final SchoolCardModel _self;
  final $Res Function(SchoolCardModel) _then;

/// Create a copy of SchoolCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schoolId = freezed,Object? ratings = freezed,Object? name = freezed,Object? feeRange = freezed,Object? area = freezed,Object? location = freezed,Object? board = freezed,Object? genderType = freezed,Object? shifts = freezed,Object? amenities = freezed,Object? schoolMode = freezed,}) {
  return _then(_self.copyWith(
schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,ratings: freezed == ratings ? _self.ratings : ratings // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,feeRange: freezed == feeRange ? _self.feeRange : feeRange // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,board: freezed == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as String?,genderType: freezed == genderType ? _self.genderType : genderType // ignore: cast_nullable_to_non_nullable
as String?,shifts: freezed == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<String>?,amenities: freezed == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>?,schoolMode: freezed == schoolMode ? _self.schoolMode : schoolMode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SchoolCardModel].
extension SchoolCardModelPatterns on SchoolCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolCardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolCardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolCardModel value)  $default,){
final _that = this;
switch (_that) {
case _SchoolCardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolCardModel value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolCardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? schoolId,  int? ratings,  String? name,  String? feeRange,  String? area,  String? location,  String? board,  String? genderType,  List<String>? shifts,  List<String>? amenities,  String? schoolMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolCardModel() when $default != null:
return $default(_that.schoolId,_that.ratings,_that.name,_that.feeRange,_that.area,_that.location,_that.board,_that.genderType,_that.shifts,_that.amenities,_that.schoolMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? schoolId,  int? ratings,  String? name,  String? feeRange,  String? area,  String? location,  String? board,  String? genderType,  List<String>? shifts,  List<String>? amenities,  String? schoolMode)  $default,) {final _that = this;
switch (_that) {
case _SchoolCardModel():
return $default(_that.schoolId,_that.ratings,_that.name,_that.feeRange,_that.area,_that.location,_that.board,_that.genderType,_that.shifts,_that.amenities,_that.schoolMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? schoolId,  int? ratings,  String? name,  String? feeRange,  String? area,  String? location,  String? board,  String? genderType,  List<String>? shifts,  List<String>? amenities,  String? schoolMode)?  $default,) {final _that = this;
switch (_that) {
case _SchoolCardModel() when $default != null:
return $default(_that.schoolId,_that.ratings,_that.name,_that.feeRange,_that.area,_that.location,_that.board,_that.genderType,_that.shifts,_that.amenities,_that.schoolMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SchoolCardModel implements SchoolCardModel {
   _SchoolCardModel({this.schoolId, this.ratings, this.name, this.feeRange, this.area, this.location, this.board, this.genderType, final  List<String>? shifts, final  List<String>? amenities, this.schoolMode}): _shifts = shifts,_amenities = amenities;
  factory _SchoolCardModel.fromJson(Map<String, dynamic> json) => _$SchoolCardModelFromJson(json);

@override final  String? schoolId;
@override final  int? ratings;
@override final  String? name;
@override final  String? feeRange;
@override final  String? area;
@override final  String? location;
@override final  String? board;
@override final  String? genderType;
 final  List<String>? _shifts;
@override List<String>? get shifts {
  final value = _shifts;
  if (value == null) return null;
  if (_shifts is EqualUnmodifiableListView) return _shifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _amenities;
@override List<String>? get amenities {
  final value = _amenities;
  if (value == null) return null;
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? schoolMode;

/// Create a copy of SchoolCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolCardModelCopyWith<_SchoolCardModel> get copyWith => __$SchoolCardModelCopyWithImpl<_SchoolCardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolCardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolCardModel&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.ratings, ratings) || other.ratings == ratings)&&(identical(other.name, name) || other.name == name)&&(identical(other.feeRange, feeRange) || other.feeRange == feeRange)&&(identical(other.area, area) || other.area == area)&&(identical(other.location, location) || other.location == location)&&(identical(other.board, board) || other.board == board)&&(identical(other.genderType, genderType) || other.genderType == genderType)&&const DeepCollectionEquality().equals(other._shifts, _shifts)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&(identical(other.schoolMode, schoolMode) || other.schoolMode == schoolMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schoolId,ratings,name,feeRange,area,location,board,genderType,const DeepCollectionEquality().hash(_shifts),const DeepCollectionEquality().hash(_amenities),schoolMode);

@override
String toString() {
  return 'SchoolCardModel(schoolId: $schoolId, ratings: $ratings, name: $name, feeRange: $feeRange, area: $area, location: $location, board: $board, genderType: $genderType, shifts: $shifts, amenities: $amenities, schoolMode: $schoolMode)';
}


}

/// @nodoc
abstract mixin class _$SchoolCardModelCopyWith<$Res> implements $SchoolCardModelCopyWith<$Res> {
  factory _$SchoolCardModelCopyWith(_SchoolCardModel value, $Res Function(_SchoolCardModel) _then) = __$SchoolCardModelCopyWithImpl;
@override @useResult
$Res call({
 String? schoolId, int? ratings, String? name, String? feeRange, String? area, String? location, String? board, String? genderType, List<String>? shifts, List<String>? amenities, String? schoolMode
});




}
/// @nodoc
class __$SchoolCardModelCopyWithImpl<$Res>
    implements _$SchoolCardModelCopyWith<$Res> {
  __$SchoolCardModelCopyWithImpl(this._self, this._then);

  final _SchoolCardModel _self;
  final $Res Function(_SchoolCardModel) _then;

/// Create a copy of SchoolCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schoolId = freezed,Object? ratings = freezed,Object? name = freezed,Object? feeRange = freezed,Object? area = freezed,Object? location = freezed,Object? board = freezed,Object? genderType = freezed,Object? shifts = freezed,Object? amenities = freezed,Object? schoolMode = freezed,}) {
  return _then(_SchoolCardModel(
schoolId: freezed == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String?,ratings: freezed == ratings ? _self.ratings : ratings // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,feeRange: freezed == feeRange ? _self.feeRange : feeRange // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,board: freezed == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as String?,genderType: freezed == genderType ? _self.genderType : genderType // ignore: cast_nullable_to_non_nullable
as String?,shifts: freezed == shifts ? _self._shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<String>?,amenities: freezed == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>?,schoolMode: freezed == schoolMode ? _self.schoolMode : schoolMode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
