// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String? get authId; String? get email; String? get contactNo; String? get dateOfBirth; String? get name; String? get gender; String? get state; String? get city; String? get area; double? get latitude; double? get longitude; List<String>? get shortlistedSchools;@UserTypeConverter() UserType? get userType;@JsonKey(name: '_id') String? get sId; String? get createdAt; String? get updatedAt;@JsonKey(name: '__v') int? get iV;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.contactNo, contactNo) || other.contactNo == contactNo)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.area, area) || other.area == area)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.shortlistedSchools, shortlistedSchools)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.iV, iV) || other.iV == iV));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authId,email,contactNo,dateOfBirth,name,gender,state,city,area,latitude,longitude,const DeepCollectionEquality().hash(shortlistedSchools),userType,sId,createdAt,updatedAt,iV);

@override
String toString() {
  return 'User(authId: $authId, email: $email, contactNo: $contactNo, dateOfBirth: $dateOfBirth, name: $name, gender: $gender, state: $state, city: $city, area: $area, latitude: $latitude, longitude: $longitude, shortlistedSchools: $shortlistedSchools, userType: $userType, sId: $sId, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String? authId, String? email, String? contactNo, String? dateOfBirth, String? name, String? gender, String? state, String? city, String? area, double? latitude, double? longitude, List<String>? shortlistedSchools,@UserTypeConverter() UserType? userType,@JsonKey(name: '_id') String? sId, String? createdAt, String? updatedAt,@JsonKey(name: '__v') int? iV
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authId = freezed,Object? email = freezed,Object? contactNo = freezed,Object? dateOfBirth = freezed,Object? name = freezed,Object? gender = freezed,Object? state = freezed,Object? city = freezed,Object? area = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? shortlistedSchools = freezed,Object? userType = freezed,Object? sId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? iV = freezed,}) {
  return _then(_self.copyWith(
authId: freezed == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,contactNo: freezed == contactNo ? _self.contactNo : contactNo // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,shortlistedSchools: freezed == shortlistedSchools ? _self.shortlistedSchools : shortlistedSchools // ignore: cast_nullable_to_non_nullable
as List<String>?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as UserType?,sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? authId,  String? email,  String? contactNo,  String? dateOfBirth,  String? name,  String? gender,  String? state,  String? city,  String? area,  double? latitude,  double? longitude,  List<String>? shortlistedSchools, @UserTypeConverter()  UserType? userType, @JsonKey(name: '_id')  String? sId,  String? createdAt,  String? updatedAt, @JsonKey(name: '__v')  int? iV)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.authId,_that.email,_that.contactNo,_that.dateOfBirth,_that.name,_that.gender,_that.state,_that.city,_that.area,_that.latitude,_that.longitude,_that.shortlistedSchools,_that.userType,_that.sId,_that.createdAt,_that.updatedAt,_that.iV);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? authId,  String? email,  String? contactNo,  String? dateOfBirth,  String? name,  String? gender,  String? state,  String? city,  String? area,  double? latitude,  double? longitude,  List<String>? shortlistedSchools, @UserTypeConverter()  UserType? userType, @JsonKey(name: '_id')  String? sId,  String? createdAt,  String? updatedAt, @JsonKey(name: '__v')  int? iV)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.authId,_that.email,_that.contactNo,_that.dateOfBirth,_that.name,_that.gender,_that.state,_that.city,_that.area,_that.latitude,_that.longitude,_that.shortlistedSchools,_that.userType,_that.sId,_that.createdAt,_that.updatedAt,_that.iV);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? authId,  String? email,  String? contactNo,  String? dateOfBirth,  String? name,  String? gender,  String? state,  String? city,  String? area,  double? latitude,  double? longitude,  List<String>? shortlistedSchools, @UserTypeConverter()  UserType? userType, @JsonKey(name: '_id')  String? sId,  String? createdAt,  String? updatedAt, @JsonKey(name: '__v')  int? iV)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.authId,_that.email,_that.contactNo,_that.dateOfBirth,_that.name,_that.gender,_that.state,_that.city,_that.area,_that.latitude,_that.longitude,_that.shortlistedSchools,_that.userType,_that.sId,_that.createdAt,_that.updatedAt,_that.iV);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({this.authId, this.email, this.contactNo, this.dateOfBirth, this.name, this.gender, this.state, this.city, this.area, this.latitude, this.longitude, final  List<String>? shortlistedSchools, @UserTypeConverter() this.userType, @JsonKey(name: '_id') this.sId, this.createdAt, this.updatedAt, @JsonKey(name: '__v') this.iV}): _shortlistedSchools = shortlistedSchools;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String? authId;
@override final  String? email;
@override final  String? contactNo;
@override final  String? dateOfBirth;
@override final  String? name;
@override final  String? gender;
@override final  String? state;
@override final  String? city;
@override final  String? area;
@override final  double? latitude;
@override final  double? longitude;
 final  List<String>? _shortlistedSchools;
@override List<String>? get shortlistedSchools {
  final value = _shortlistedSchools;
  if (value == null) return null;
  if (_shortlistedSchools is EqualUnmodifiableListView) return _shortlistedSchools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@UserTypeConverter() final  UserType? userType;
@override@JsonKey(name: '_id') final  String? sId;
@override final  String? createdAt;
@override final  String? updatedAt;
@override@JsonKey(name: '__v') final  int? iV;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.email, email) || other.email == email)&&(identical(other.contactNo, contactNo) || other.contactNo == contactNo)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.area, area) || other.area == area)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._shortlistedSchools, _shortlistedSchools)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.iV, iV) || other.iV == iV));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authId,email,contactNo,dateOfBirth,name,gender,state,city,area,latitude,longitude,const DeepCollectionEquality().hash(_shortlistedSchools),userType,sId,createdAt,updatedAt,iV);

@override
String toString() {
  return 'User(authId: $authId, email: $email, contactNo: $contactNo, dateOfBirth: $dateOfBirth, name: $name, gender: $gender, state: $state, city: $city, area: $area, latitude: $latitude, longitude: $longitude, shortlistedSchools: $shortlistedSchools, userType: $userType, sId: $sId, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String? authId, String? email, String? contactNo, String? dateOfBirth, String? name, String? gender, String? state, String? city, String? area, double? latitude, double? longitude, List<String>? shortlistedSchools,@UserTypeConverter() UserType? userType,@JsonKey(name: '_id') String? sId, String? createdAt, String? updatedAt,@JsonKey(name: '__v') int? iV
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authId = freezed,Object? email = freezed,Object? contactNo = freezed,Object? dateOfBirth = freezed,Object? name = freezed,Object? gender = freezed,Object? state = freezed,Object? city = freezed,Object? area = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? shortlistedSchools = freezed,Object? userType = freezed,Object? sId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? iV = freezed,}) {
  return _then(_User(
authId: freezed == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,contactNo: freezed == contactNo ? _self.contactNo : contactNo // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,shortlistedSchools: freezed == shortlistedSchools ? _self._shortlistedSchools : shortlistedSchools // ignore: cast_nullable_to_non_nullable
as List<String>?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as UserType?,sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
