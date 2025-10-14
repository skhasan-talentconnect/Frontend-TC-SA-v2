// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applied_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppliedFormModel {

 String? get formId; bool? get isApplied;@FormStatusConverter() FormStatus? get status;
/// Create a copy of AppliedFormModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppliedFormModelCopyWith<AppliedFormModel> get copyWith => _$AppliedFormModelCopyWithImpl<AppliedFormModel>(this as AppliedFormModel, _$identity);

  /// Serializes this AppliedFormModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppliedFormModel&&(identical(other.formId, formId) || other.formId == formId)&&(identical(other.isApplied, isApplied) || other.isApplied == isApplied)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,formId,isApplied,status);

@override
String toString() {
  return 'AppliedFormModel(formId: $formId, isApplied: $isApplied, status: $status)';
}


}

/// @nodoc
abstract mixin class $AppliedFormModelCopyWith<$Res>  {
  factory $AppliedFormModelCopyWith(AppliedFormModel value, $Res Function(AppliedFormModel) _then) = _$AppliedFormModelCopyWithImpl;
@useResult
$Res call({
 String? formId, bool? isApplied,@FormStatusConverter() FormStatus? status
});




}
/// @nodoc
class _$AppliedFormModelCopyWithImpl<$Res>
    implements $AppliedFormModelCopyWith<$Res> {
  _$AppliedFormModelCopyWithImpl(this._self, this._then);

  final AppliedFormModel _self;
  final $Res Function(AppliedFormModel) _then;

/// Create a copy of AppliedFormModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formId = freezed,Object? isApplied = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
formId: freezed == formId ? _self.formId : formId // ignore: cast_nullable_to_non_nullable
as String?,isApplied: freezed == isApplied ? _self.isApplied : isApplied // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppliedFormModel].
extension AppliedFormModelPatterns on AppliedFormModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppliedFormModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppliedFormModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppliedFormModel value)  $default,){
final _that = this;
switch (_that) {
case _AppliedFormModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppliedFormModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppliedFormModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? formId,  bool? isApplied, @FormStatusConverter()  FormStatus? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppliedFormModel() when $default != null:
return $default(_that.formId,_that.isApplied,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? formId,  bool? isApplied, @FormStatusConverter()  FormStatus? status)  $default,) {final _that = this;
switch (_that) {
case _AppliedFormModel():
return $default(_that.formId,_that.isApplied,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? formId,  bool? isApplied, @FormStatusConverter()  FormStatus? status)?  $default,) {final _that = this;
switch (_that) {
case _AppliedFormModel() when $default != null:
return $default(_that.formId,_that.isApplied,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppliedFormModel implements AppliedFormModel {
  const _AppliedFormModel({this.formId, this.isApplied, @FormStatusConverter() this.status});
  factory _AppliedFormModel.fromJson(Map<String, dynamic> json) => _$AppliedFormModelFromJson(json);

@override final  String? formId;
@override final  bool? isApplied;
@override@FormStatusConverter() final  FormStatus? status;

/// Create a copy of AppliedFormModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppliedFormModelCopyWith<_AppliedFormModel> get copyWith => __$AppliedFormModelCopyWithImpl<_AppliedFormModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppliedFormModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppliedFormModel&&(identical(other.formId, formId) || other.formId == formId)&&(identical(other.isApplied, isApplied) || other.isApplied == isApplied)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,formId,isApplied,status);

@override
String toString() {
  return 'AppliedFormModel(formId: $formId, isApplied: $isApplied, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AppliedFormModelCopyWith<$Res> implements $AppliedFormModelCopyWith<$Res> {
  factory _$AppliedFormModelCopyWith(_AppliedFormModel value, $Res Function(_AppliedFormModel) _then) = __$AppliedFormModelCopyWithImpl;
@override @useResult
$Res call({
 String? formId, bool? isApplied,@FormStatusConverter() FormStatus? status
});




}
/// @nodoc
class __$AppliedFormModelCopyWithImpl<$Res>
    implements _$AppliedFormModelCopyWith<$Res> {
  __$AppliedFormModelCopyWithImpl(this._self, this._then);

  final _AppliedFormModel _self;
  final $Res Function(_AppliedFormModel) _then;

/// Create a copy of AppliedFormModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formId = freezed,Object? isApplied = freezed,Object? status = freezed,}) {
  return _then(_AppliedFormModel(
formId: freezed == formId ? _self.formId : formId // ignore: cast_nullable_to_non_nullable
as String?,isApplied: freezed == isApplied ? _self.isApplied : isApplied // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus?,
  ));
}


}

// dart format on
