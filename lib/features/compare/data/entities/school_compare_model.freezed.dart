// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_compare_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SchoolCompareModel {

 String get name; String get board; String get feeRange; String get schoolMode; List<String> get shifts; List<String> get predefinedAmenities; List<String> get activities;
/// Create a copy of SchoolCompareModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolCompareModelCopyWith<SchoolCompareModel> get copyWith => _$SchoolCompareModelCopyWithImpl<SchoolCompareModel>(this as SchoolCompareModel, _$identity);

  /// Serializes this SchoolCompareModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolCompareModel&&(identical(other.name, name) || other.name == name)&&(identical(other.board, board) || other.board == board)&&(identical(other.feeRange, feeRange) || other.feeRange == feeRange)&&(identical(other.schoolMode, schoolMode) || other.schoolMode == schoolMode)&&const DeepCollectionEquality().equals(other.shifts, shifts)&&const DeepCollectionEquality().equals(other.predefinedAmenities, predefinedAmenities)&&const DeepCollectionEquality().equals(other.activities, activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,board,feeRange,schoolMode,const DeepCollectionEquality().hash(shifts),const DeepCollectionEquality().hash(predefinedAmenities),const DeepCollectionEquality().hash(activities));

@override
String toString() {
  return 'SchoolCompareModel(name: $name, board: $board, feeRange: $feeRange, schoolMode: $schoolMode, shifts: $shifts, predefinedAmenities: $predefinedAmenities, activities: $activities)';
}


}

/// @nodoc
abstract mixin class $SchoolCompareModelCopyWith<$Res>  {
  factory $SchoolCompareModelCopyWith(SchoolCompareModel value, $Res Function(SchoolCompareModel) _then) = _$SchoolCompareModelCopyWithImpl;
@useResult
$Res call({
 String name, String board, String feeRange, String schoolMode, List<String> shifts, List<String> predefinedAmenities, List<String> activities
});




}
/// @nodoc
class _$SchoolCompareModelCopyWithImpl<$Res>
    implements $SchoolCompareModelCopyWith<$Res> {
  _$SchoolCompareModelCopyWithImpl(this._self, this._then);

  final SchoolCompareModel _self;
  final $Res Function(SchoolCompareModel) _then;

/// Create a copy of SchoolCompareModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? board = null,Object? feeRange = null,Object? schoolMode = null,Object? shifts = null,Object? predefinedAmenities = null,Object? activities = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as String,feeRange: null == feeRange ? _self.feeRange : feeRange // ignore: cast_nullable_to_non_nullable
as String,schoolMode: null == schoolMode ? _self.schoolMode : schoolMode // ignore: cast_nullable_to_non_nullable
as String,shifts: null == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<String>,predefinedAmenities: null == predefinedAmenities ? _self.predefinedAmenities : predefinedAmenities // ignore: cast_nullable_to_non_nullable
as List<String>,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SchoolCompareModel].
extension SchoolCompareModelPatterns on SchoolCompareModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolCompareModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolCompareModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolCompareModel value)  $default,){
final _that = this;
switch (_that) {
case _SchoolCompareModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolCompareModel value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolCompareModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String board,  String feeRange,  String schoolMode,  List<String> shifts,  List<String> predefinedAmenities,  List<String> activities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolCompareModel() when $default != null:
return $default(_that.name,_that.board,_that.feeRange,_that.schoolMode,_that.shifts,_that.predefinedAmenities,_that.activities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String board,  String feeRange,  String schoolMode,  List<String> shifts,  List<String> predefinedAmenities,  List<String> activities)  $default,) {final _that = this;
switch (_that) {
case _SchoolCompareModel():
return $default(_that.name,_that.board,_that.feeRange,_that.schoolMode,_that.shifts,_that.predefinedAmenities,_that.activities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String board,  String feeRange,  String schoolMode,  List<String> shifts,  List<String> predefinedAmenities,  List<String> activities)?  $default,) {final _that = this;
switch (_that) {
case _SchoolCompareModel() when $default != null:
return $default(_that.name,_that.board,_that.feeRange,_that.schoolMode,_that.shifts,_that.predefinedAmenities,_that.activities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SchoolCompareModel implements SchoolCompareModel {
  const _SchoolCompareModel({required this.name, required this.board, required this.feeRange, required this.schoolMode, required final  List<String> shifts, required final  List<String> predefinedAmenities, required final  List<String> activities}): _shifts = shifts,_predefinedAmenities = predefinedAmenities,_activities = activities;
  factory _SchoolCompareModel.fromJson(Map<String, dynamic> json) => _$SchoolCompareModelFromJson(json);

@override final  String name;
@override final  String board;
@override final  String feeRange;
@override final  String schoolMode;
 final  List<String> _shifts;
@override List<String> get shifts {
  if (_shifts is EqualUnmodifiableListView) return _shifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shifts);
}

 final  List<String> _predefinedAmenities;
@override List<String> get predefinedAmenities {
  if (_predefinedAmenities is EqualUnmodifiableListView) return _predefinedAmenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predefinedAmenities);
}

 final  List<String> _activities;
@override List<String> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}


/// Create a copy of SchoolCompareModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolCompareModelCopyWith<_SchoolCompareModel> get copyWith => __$SchoolCompareModelCopyWithImpl<_SchoolCompareModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolCompareModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolCompareModel&&(identical(other.name, name) || other.name == name)&&(identical(other.board, board) || other.board == board)&&(identical(other.feeRange, feeRange) || other.feeRange == feeRange)&&(identical(other.schoolMode, schoolMode) || other.schoolMode == schoolMode)&&const DeepCollectionEquality().equals(other._shifts, _shifts)&&const DeepCollectionEquality().equals(other._predefinedAmenities, _predefinedAmenities)&&const DeepCollectionEquality().equals(other._activities, _activities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,board,feeRange,schoolMode,const DeepCollectionEquality().hash(_shifts),const DeepCollectionEquality().hash(_predefinedAmenities),const DeepCollectionEquality().hash(_activities));

@override
String toString() {
  return 'SchoolCompareModel(name: $name, board: $board, feeRange: $feeRange, schoolMode: $schoolMode, shifts: $shifts, predefinedAmenities: $predefinedAmenities, activities: $activities)';
}


}

/// @nodoc
abstract mixin class _$SchoolCompareModelCopyWith<$Res> implements $SchoolCompareModelCopyWith<$Res> {
  factory _$SchoolCompareModelCopyWith(_SchoolCompareModel value, $Res Function(_SchoolCompareModel) _then) = __$SchoolCompareModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String board, String feeRange, String schoolMode, List<String> shifts, List<String> predefinedAmenities, List<String> activities
});




}
/// @nodoc
class __$SchoolCompareModelCopyWithImpl<$Res>
    implements _$SchoolCompareModelCopyWith<$Res> {
  __$SchoolCompareModelCopyWithImpl(this._self, this._then);

  final _SchoolCompareModel _self;
  final $Res Function(_SchoolCompareModel) _then;

/// Create a copy of SchoolCompareModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? board = null,Object? feeRange = null,Object? schoolMode = null,Object? shifts = null,Object? predefinedAmenities = null,Object? activities = null,}) {
  return _then(_SchoolCompareModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as String,feeRange: null == feeRange ? _self.feeRange : feeRange // ignore: cast_nullable_to_non_nullable
as String,schoolMode: null == schoolMode ? _self.schoolMode : schoolMode // ignore: cast_nullable_to_non_nullable
as String,shifts: null == shifts ? _self._shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<String>,predefinedAmenities: null == predefinedAmenities ? _self._predefinedAmenities : predefinedAmenities // ignore: cast_nullable_to_non_nullable
as List<String>,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
