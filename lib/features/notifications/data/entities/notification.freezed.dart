// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Notification {

@JsonKey(name: '_id') String? get sId; String? get authId; String? get title; String? get body; String? get path;@NotificationTypeConverter() NotificationType? get notificationType;@JsonKey(name: 'is_read') bool? get isRead; Map<String, dynamic>? get data; String? get createdAt; String? get updatedAt;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.path, path) || other.path == path)&&(identical(other.notificationType, notificationType) || other.notificationType == notificationType)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,authId,title,body,path,notificationType,isRead,const DeepCollectionEquality().hash(data),createdAt,updatedAt);

@override
String toString() {
  return 'Notification(sId: $sId, authId: $authId, title: $title, body: $body, path: $path, notificationType: $notificationType, isRead: $isRead, data: $data, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? sId, String? authId, String? title, String? body, String? path,@NotificationTypeConverter() NotificationType? notificationType,@JsonKey(name: 'is_read') bool? isRead, Map<String, dynamic>? data, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$NotificationCopyWithImpl<$Res>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._self, this._then);

  final Notification _self;
  final $Res Function(Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sId = freezed,Object? authId = freezed,Object? title = freezed,Object? body = freezed,Object? path = freezed,Object? notificationType = freezed,Object? isRead = freezed,Object? data = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,authId: freezed == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,notificationType: freezed == notificationType ? _self.notificationType : notificationType // ignore: cast_nullable_to_non_nullable
as NotificationType?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Notification].
extension NotificationPatterns on Notification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notification value)  $default,){
final _that = this;
switch (_that) {
case _Notification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notification value)?  $default,){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? sId,  String? authId,  String? title,  String? body,  String? path, @NotificationTypeConverter()  NotificationType? notificationType, @JsonKey(name: 'is_read')  bool? isRead,  Map<String, dynamic>? data,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.sId,_that.authId,_that.title,_that.body,_that.path,_that.notificationType,_that.isRead,_that.data,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? sId,  String? authId,  String? title,  String? body,  String? path, @NotificationTypeConverter()  NotificationType? notificationType, @JsonKey(name: 'is_read')  bool? isRead,  Map<String, dynamic>? data,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Notification():
return $default(_that.sId,_that.authId,_that.title,_that.body,_that.path,_that.notificationType,_that.isRead,_that.data,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? sId,  String? authId,  String? title,  String? body,  String? path, @NotificationTypeConverter()  NotificationType? notificationType, @JsonKey(name: 'is_read')  bool? isRead,  Map<String, dynamic>? data,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.sId,_that.authId,_that.title,_that.body,_that.path,_that.notificationType,_that.isRead,_that.data,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Notification implements Notification {
  const _Notification({@JsonKey(name: '_id') this.sId, this.authId, this.title, this.body, this.path, @NotificationTypeConverter() this.notificationType, @JsonKey(name: 'is_read') this.isRead, final  Map<String, dynamic>? data, this.createdAt, this.updatedAt}): _data = data;
  factory _Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

@override@JsonKey(name: '_id') final  String? sId;
@override final  String? authId;
@override final  String? title;
@override final  String? body;
@override final  String? path;
@override@NotificationTypeConverter() final  NotificationType? notificationType;
@override@JsonKey(name: 'is_read') final  bool? isRead;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCopyWith<_Notification> get copyWith => __$NotificationCopyWithImpl<_Notification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notification&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.authId, authId) || other.authId == authId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.path, path) || other.path == path)&&(identical(other.notificationType, notificationType) || other.notificationType == notificationType)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,authId,title,body,path,notificationType,isRead,const DeepCollectionEquality().hash(_data),createdAt,updatedAt);

@override
String toString() {
  return 'Notification(sId: $sId, authId: $authId, title: $title, body: $body, path: $path, notificationType: $notificationType, isRead: $isRead, data: $data, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(_Notification value, $Res Function(_Notification) _then) = __$NotificationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? sId, String? authId, String? title, String? body, String? path,@NotificationTypeConverter() NotificationType? notificationType,@JsonKey(name: 'is_read') bool? isRead, Map<String, dynamic>? data, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(this._self, this._then);

  final _Notification _self;
  final $Res Function(_Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sId = freezed,Object? authId = freezed,Object? title = freezed,Object? body = freezed,Object? path = freezed,Object? notificationType = freezed,Object? isRead = freezed,Object? data = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Notification(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,authId: freezed == authId ? _self.authId : authId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,notificationType: freezed == notificationType ? _self.notificationType : notificationType // ignore: cast_nullable_to_non_nullable
as NotificationType?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
