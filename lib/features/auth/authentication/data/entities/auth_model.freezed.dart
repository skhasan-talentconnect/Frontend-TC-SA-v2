// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthModel {

@JsonKey(name: '_id') String? get sId; String? get email; String? get password; bool? get isEmailVerified; String? get userType; String? get authProvider; String? get deviceToken; String? get createdAt; String? get updatedAt;@JsonKey(name: '__v') int? get iV;
/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthModelCopyWith<AuthModel> get copyWith => _$AuthModelCopyWithImpl<AuthModel>(this as AuthModel, _$identity);

  /// Serializes this AuthModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthModel&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.iV, iV) || other.iV == iV));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,email,password,isEmailVerified,userType,authProvider,deviceToken,createdAt,updatedAt,iV);

@override
String toString() {
  return 'AuthModel(sId: $sId, email: $email, password: $password, isEmailVerified: $isEmailVerified, userType: $userType, authProvider: $authProvider, deviceToken: $deviceToken, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
}


}

/// @nodoc
abstract mixin class $AuthModelCopyWith<$Res>  {
  factory $AuthModelCopyWith(AuthModel value, $Res Function(AuthModel) _then) = _$AuthModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? sId, String? email, String? password, bool? isEmailVerified, String? userType, String? authProvider, String? deviceToken, String? createdAt, String? updatedAt,@JsonKey(name: '__v') int? iV
});




}
/// @nodoc
class _$AuthModelCopyWithImpl<$Res>
    implements $AuthModelCopyWith<$Res> {
  _$AuthModelCopyWithImpl(this._self, this._then);

  final AuthModel _self;
  final $Res Function(AuthModel) _then;

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sId = freezed,Object? email = freezed,Object? password = freezed,Object? isEmailVerified = freezed,Object? userType = freezed,Object? authProvider = freezed,Object? deviceToken = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? iV = freezed,}) {
  return _then(_self.copyWith(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: freezed == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,authProvider: freezed == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String?,deviceToken: freezed == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthModel].
extension AuthModelPatterns on AuthModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthModel value)  $default,){
final _that = this;
switch (_that) {
case _AuthModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthModel value)?  $default,){
final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? sId,  String? email,  String? password,  bool? isEmailVerified,  String? userType,  String? authProvider,  String? deviceToken,  String? createdAt,  String? updatedAt, @JsonKey(name: '__v')  int? iV)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
return $default(_that.sId,_that.email,_that.password,_that.isEmailVerified,_that.userType,_that.authProvider,_that.deviceToken,_that.createdAt,_that.updatedAt,_that.iV);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? sId,  String? email,  String? password,  bool? isEmailVerified,  String? userType,  String? authProvider,  String? deviceToken,  String? createdAt,  String? updatedAt, @JsonKey(name: '__v')  int? iV)  $default,) {final _that = this;
switch (_that) {
case _AuthModel():
return $default(_that.sId,_that.email,_that.password,_that.isEmailVerified,_that.userType,_that.authProvider,_that.deviceToken,_that.createdAt,_that.updatedAt,_that.iV);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? sId,  String? email,  String? password,  bool? isEmailVerified,  String? userType,  String? authProvider,  String? deviceToken,  String? createdAt,  String? updatedAt, @JsonKey(name: '__v')  int? iV)?  $default,) {final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
return $default(_that.sId,_that.email,_that.password,_that.isEmailVerified,_that.userType,_that.authProvider,_that.deviceToken,_that.createdAt,_that.updatedAt,_that.iV);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthModel implements AuthModel {
  const _AuthModel({@JsonKey(name: '_id') this.sId, this.email, this.password, this.isEmailVerified, this.userType, this.authProvider, this.deviceToken, this.createdAt, this.updatedAt, @JsonKey(name: '__v') this.iV});
  factory _AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

@override@JsonKey(name: '_id') final  String? sId;
@override final  String? email;
@override final  String? password;
@override final  bool? isEmailVerified;
@override final  String? userType;
@override final  String? authProvider;
@override final  String? deviceToken;
@override final  String? createdAt;
@override final  String? updatedAt;
@override@JsonKey(name: '__v') final  int? iV;

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthModelCopyWith<_AuthModel> get copyWith => __$AuthModelCopyWithImpl<_AuthModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthModel&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.iV, iV) || other.iV == iV));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,email,password,isEmailVerified,userType,authProvider,deviceToken,createdAt,updatedAt,iV);

@override
String toString() {
  return 'AuthModel(sId: $sId, email: $email, password: $password, isEmailVerified: $isEmailVerified, userType: $userType, authProvider: $authProvider, deviceToken: $deviceToken, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
}


}

/// @nodoc
abstract mixin class _$AuthModelCopyWith<$Res> implements $AuthModelCopyWith<$Res> {
  factory _$AuthModelCopyWith(_AuthModel value, $Res Function(_AuthModel) _then) = __$AuthModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? sId, String? email, String? password, bool? isEmailVerified, String? userType, String? authProvider, String? deviceToken, String? createdAt, String? updatedAt,@JsonKey(name: '__v') int? iV
});




}
/// @nodoc
class __$AuthModelCopyWithImpl<$Res>
    implements _$AuthModelCopyWith<$Res> {
  __$AuthModelCopyWithImpl(this._self, this._then);

  final _AuthModel _self;
  final $Res Function(_AuthModel) _then;

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sId = freezed,Object? email = freezed,Object? password = freezed,Object? isEmailVerified = freezed,Object? userType = freezed,Object? authProvider = freezed,Object? deviceToken = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? iV = freezed,}) {
  return _then(_AuthModel(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: freezed == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,authProvider: freezed == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String?,deviceToken: freezed == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
