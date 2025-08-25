// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_pref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPref {

 String? get sId; String? get studentId; String? get state; String? get city; String? get boards; String? get preferredStandard; String? get interests; String? get schoolType; String? get shift; String? get createdAt; String? get updatedAt; int? get iV;
/// Create a copy of UserPref
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPrefCopyWith<UserPref> get copyWith => _$UserPrefCopyWithImpl<UserPref>(this as UserPref, _$identity);

  /// Serializes this UserPref to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPref&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.boards, boards) || other.boards == boards)&&(identical(other.preferredStandard, preferredStandard) || other.preferredStandard == preferredStandard)&&(identical(other.interests, interests) || other.interests == interests)&&(identical(other.schoolType, schoolType) || other.schoolType == schoolType)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.iV, iV) || other.iV == iV));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,studentId,state,city,boards,preferredStandard,interests,schoolType,shift,createdAt,updatedAt,iV);

@override
String toString() {
  return 'UserPref(sId: $sId, studentId: $studentId, state: $state, city: $city, boards: $boards, preferredStandard: $preferredStandard, interests: $interests, schoolType: $schoolType, shift: $shift, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
}


}

/// @nodoc
abstract mixin class $UserPrefCopyWith<$Res>  {
  factory $UserPrefCopyWith(UserPref value, $Res Function(UserPref) _then) = _$UserPrefCopyWithImpl;
@useResult
$Res call({
 String? sId, String? studentId, String? state, String? city, String? boards, String? preferredStandard, String? interests, String? schoolType, String? shift, String? createdAt, String? updatedAt, int? iV
});




}
/// @nodoc
class _$UserPrefCopyWithImpl<$Res>
    implements $UserPrefCopyWith<$Res> {
  _$UserPrefCopyWithImpl(this._self, this._then);

  final UserPref _self;
  final $Res Function(UserPref) _then;

/// Create a copy of UserPref
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sId = freezed,Object? studentId = freezed,Object? state = freezed,Object? city = freezed,Object? boards = freezed,Object? preferredStandard = freezed,Object? interests = freezed,Object? schoolType = freezed,Object? shift = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? iV = freezed,}) {
  return _then(_self.copyWith(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,boards: freezed == boards ? _self.boards : boards // ignore: cast_nullable_to_non_nullable
as String?,preferredStandard: freezed == preferredStandard ? _self.preferredStandard : preferredStandard // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as String?,schoolType: freezed == schoolType ? _self.schoolType : schoolType // ignore: cast_nullable_to_non_nullable
as String?,shift: freezed == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPref].
extension UserPrefPatterns on UserPref {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPref value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPref() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPref value)  $default,){
final _that = this;
switch (_that) {
case _UserPref():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPref value)?  $default,){
final _that = this;
switch (_that) {
case _UserPref() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sId,  String? studentId,  String? state,  String? city,  String? boards,  String? preferredStandard,  String? interests,  String? schoolType,  String? shift,  String? createdAt,  String? updatedAt,  int? iV)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPref() when $default != null:
return $default(_that.sId,_that.studentId,_that.state,_that.city,_that.boards,_that.preferredStandard,_that.interests,_that.schoolType,_that.shift,_that.createdAt,_that.updatedAt,_that.iV);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sId,  String? studentId,  String? state,  String? city,  String? boards,  String? preferredStandard,  String? interests,  String? schoolType,  String? shift,  String? createdAt,  String? updatedAt,  int? iV)  $default,) {final _that = this;
switch (_that) {
case _UserPref():
return $default(_that.sId,_that.studentId,_that.state,_that.city,_that.boards,_that.preferredStandard,_that.interests,_that.schoolType,_that.shift,_that.createdAt,_that.updatedAt,_that.iV);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sId,  String? studentId,  String? state,  String? city,  String? boards,  String? preferredStandard,  String? interests,  String? schoolType,  String? shift,  String? createdAt,  String? updatedAt,  int? iV)?  $default,) {final _that = this;
switch (_that) {
case _UserPref() when $default != null:
return $default(_that.sId,_that.studentId,_that.state,_that.city,_that.boards,_that.preferredStandard,_that.interests,_that.schoolType,_that.shift,_that.createdAt,_that.updatedAt,_that.iV);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPref implements UserPref {
  const _UserPref({this.sId, this.studentId, this.state, this.city, this.boards, this.preferredStandard, this.interests, this.schoolType, this.shift, this.createdAt, this.updatedAt, this.iV});
  factory _UserPref.fromJson(Map<String, dynamic> json) => _$UserPrefFromJson(json);

@override final  String? sId;
@override final  String? studentId;
@override final  String? state;
@override final  String? city;
@override final  String? boards;
@override final  String? preferredStandard;
@override final  String? interests;
@override final  String? schoolType;
@override final  String? shift;
@override final  String? createdAt;
@override final  String? updatedAt;
@override final  int? iV;

/// Create a copy of UserPref
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPrefCopyWith<_UserPref> get copyWith => __$UserPrefCopyWithImpl<_UserPref>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPrefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPref&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.boards, boards) || other.boards == boards)&&(identical(other.preferredStandard, preferredStandard) || other.preferredStandard == preferredStandard)&&(identical(other.interests, interests) || other.interests == interests)&&(identical(other.schoolType, schoolType) || other.schoolType == schoolType)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.iV, iV) || other.iV == iV));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,studentId,state,city,boards,preferredStandard,interests,schoolType,shift,createdAt,updatedAt,iV);

@override
String toString() {
  return 'UserPref(sId: $sId, studentId: $studentId, state: $state, city: $city, boards: $boards, preferredStandard: $preferredStandard, interests: $interests, schoolType: $schoolType, shift: $shift, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
}


}

/// @nodoc
abstract mixin class _$UserPrefCopyWith<$Res> implements $UserPrefCopyWith<$Res> {
  factory _$UserPrefCopyWith(_UserPref value, $Res Function(_UserPref) _then) = __$UserPrefCopyWithImpl;
@override @useResult
$Res call({
 String? sId, String? studentId, String? state, String? city, String? boards, String? preferredStandard, String? interests, String? schoolType, String? shift, String? createdAt, String? updatedAt, int? iV
});




}
/// @nodoc
class __$UserPrefCopyWithImpl<$Res>
    implements _$UserPrefCopyWith<$Res> {
  __$UserPrefCopyWithImpl(this._self, this._then);

  final _UserPref _self;
  final $Res Function(_UserPref) _then;

/// Create a copy of UserPref
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sId = freezed,Object? studentId = freezed,Object? state = freezed,Object? city = freezed,Object? boards = freezed,Object? preferredStandard = freezed,Object? interests = freezed,Object? schoolType = freezed,Object? shift = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? iV = freezed,}) {
  return _then(_UserPref(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,boards: freezed == boards ? _self.boards : boards // ignore: cast_nullable_to_non_nullable
as String?,preferredStandard: freezed == preferredStandard ? _self.preferredStandard : preferredStandard // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as String?,schoolType: freezed == schoolType ? _self.schoolType : schoolType // ignore: cast_nullable_to_non_nullable
as String?,shift: freezed == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
