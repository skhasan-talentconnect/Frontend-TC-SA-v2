// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Form {

@JsonKey(name: '_id') String? get sId;@JsonKey(name: 'schoolId') SchoolModel? get school;@JsonKey(name: 'studId') User? get user;@JsonKey(name: 'interviewNote') String? get interviewNote;@FormStatusConverter() FormStatus? get status;@JsonKey(name: 'applicationId') StudentApplication? get application;@JsonKey(name: '__v') int? get iV; int? get amount;@StringOrPaymentStatusConverter() PaymentStatus? get payment; Payment? get paymentInfo;@DateTimeConverter() DateTime? get createdAt;@DateTimeConverter() DateTime? get updatedAt;
/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormCopyWith<Form> get copyWith => _$FormCopyWithImpl<Form>(this as Form, _$identity);

  /// Serializes this Form to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Form&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.school, school) || other.school == school)&&(identical(other.user, user) || other.user == user)&&(identical(other.interviewNote, interviewNote) || other.interviewNote == interviewNote)&&(identical(other.status, status) || other.status == status)&&(identical(other.application, application) || other.application == application)&&(identical(other.iV, iV) || other.iV == iV)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.paymentInfo, paymentInfo) || other.paymentInfo == paymentInfo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,school,user,interviewNote,status,application,iV,amount,payment,paymentInfo,createdAt,updatedAt);

@override
String toString() {
  return 'Form(sId: $sId, school: $school, user: $user, interviewNote: $interviewNote, status: $status, application: $application, iV: $iV, amount: $amount, payment: $payment, paymentInfo: $paymentInfo, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FormCopyWith<$Res>  {
  factory $FormCopyWith(Form value, $Res Function(Form) _then) = _$FormCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? sId,@JsonKey(name: 'schoolId') SchoolModel? school,@JsonKey(name: 'studId') User? user,@JsonKey(name: 'interviewNote') String? interviewNote,@FormStatusConverter() FormStatus? status,@JsonKey(name: 'applicationId') StudentApplication? application,@JsonKey(name: '__v') int? iV, int? amount,@StringOrPaymentStatusConverter() PaymentStatus? payment, Payment? paymentInfo,@DateTimeConverter() DateTime? createdAt,@DateTimeConverter() DateTime? updatedAt
});


$UserCopyWith<$Res>? get user;$PaymentCopyWith<$Res>? get paymentInfo;

}
/// @nodoc
class _$FormCopyWithImpl<$Res>
    implements $FormCopyWith<$Res> {
  _$FormCopyWithImpl(this._self, this._then);

  final Form _self;
  final $Res Function(Form) _then;

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sId = freezed,Object? school = freezed,Object? user = freezed,Object? interviewNote = freezed,Object? status = freezed,Object? application = freezed,Object? iV = freezed,Object? amount = freezed,Object? payment = freezed,Object? paymentInfo = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as SchoolModel?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,interviewNote: freezed == interviewNote ? _self.interviewNote : interviewNote // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus?,application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as StudentApplication?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentStatus?,paymentInfo: freezed == paymentInfo ? _self.paymentInfo : paymentInfo // ignore: cast_nullable_to_non_nullable
as Payment?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentCopyWith<$Res>? get paymentInfo {
    if (_self.paymentInfo == null) {
    return null;
  }

  return $PaymentCopyWith<$Res>(_self.paymentInfo!, (value) {
    return _then(_self.copyWith(paymentInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [Form].
extension FormPatterns on Form {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Form value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Form() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Form value)  $default,){
final _that = this;
switch (_that) {
case _Form():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Form value)?  $default,){
final _that = this;
switch (_that) {
case _Form() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? sId, @JsonKey(name: 'schoolId')  SchoolModel? school, @JsonKey(name: 'studId')  User? user, @JsonKey(name: 'interviewNote')  String? interviewNote, @FormStatusConverter()  FormStatus? status, @JsonKey(name: 'applicationId')  StudentApplication? application, @JsonKey(name: '__v')  int? iV,  int? amount, @StringOrPaymentStatusConverter()  PaymentStatus? payment,  Payment? paymentInfo, @DateTimeConverter()  DateTime? createdAt, @DateTimeConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Form() when $default != null:
return $default(_that.sId,_that.school,_that.user,_that.interviewNote,_that.status,_that.application,_that.iV,_that.amount,_that.payment,_that.paymentInfo,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? sId, @JsonKey(name: 'schoolId')  SchoolModel? school, @JsonKey(name: 'studId')  User? user, @JsonKey(name: 'interviewNote')  String? interviewNote, @FormStatusConverter()  FormStatus? status, @JsonKey(name: 'applicationId')  StudentApplication? application, @JsonKey(name: '__v')  int? iV,  int? amount, @StringOrPaymentStatusConverter()  PaymentStatus? payment,  Payment? paymentInfo, @DateTimeConverter()  DateTime? createdAt, @DateTimeConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Form():
return $default(_that.sId,_that.school,_that.user,_that.interviewNote,_that.status,_that.application,_that.iV,_that.amount,_that.payment,_that.paymentInfo,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? sId, @JsonKey(name: 'schoolId')  SchoolModel? school, @JsonKey(name: 'studId')  User? user, @JsonKey(name: 'interviewNote')  String? interviewNote, @FormStatusConverter()  FormStatus? status, @JsonKey(name: 'applicationId')  StudentApplication? application, @JsonKey(name: '__v')  int? iV,  int? amount, @StringOrPaymentStatusConverter()  PaymentStatus? payment,  Payment? paymentInfo, @DateTimeConverter()  DateTime? createdAt, @DateTimeConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Form() when $default != null:
return $default(_that.sId,_that.school,_that.user,_that.interviewNote,_that.status,_that.application,_that.iV,_that.amount,_that.payment,_that.paymentInfo,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Form implements Form {
  const _Form({@JsonKey(name: '_id') this.sId, @JsonKey(name: 'schoolId') this.school, @JsonKey(name: 'studId') this.user, @JsonKey(name: 'interviewNote') this.interviewNote, @FormStatusConverter() this.status, @JsonKey(name: 'applicationId') this.application, @JsonKey(name: '__v') this.iV, this.amount, @StringOrPaymentStatusConverter() this.payment, this.paymentInfo, @DateTimeConverter() this.createdAt, @DateTimeConverter() this.updatedAt});
  factory _Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);

@override@JsonKey(name: '_id') final  String? sId;
@override@JsonKey(name: 'schoolId') final  SchoolModel? school;
@override@JsonKey(name: 'studId') final  User? user;
@override@JsonKey(name: 'interviewNote') final  String? interviewNote;
@override@FormStatusConverter() final  FormStatus? status;
@override@JsonKey(name: 'applicationId') final  StudentApplication? application;
@override@JsonKey(name: '__v') final  int? iV;
@override final  int? amount;
@override@StringOrPaymentStatusConverter() final  PaymentStatus? payment;
@override final  Payment? paymentInfo;
@override@DateTimeConverter() final  DateTime? createdAt;
@override@DateTimeConverter() final  DateTime? updatedAt;

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormCopyWith<_Form> get copyWith => __$FormCopyWithImpl<_Form>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Form&&(identical(other.sId, sId) || other.sId == sId)&&(identical(other.school, school) || other.school == school)&&(identical(other.user, user) || other.user == user)&&(identical(other.interviewNote, interviewNote) || other.interviewNote == interviewNote)&&(identical(other.status, status) || other.status == status)&&(identical(other.application, application) || other.application == application)&&(identical(other.iV, iV) || other.iV == iV)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.paymentInfo, paymentInfo) || other.paymentInfo == paymentInfo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sId,school,user,interviewNote,status,application,iV,amount,payment,paymentInfo,createdAt,updatedAt);

@override
String toString() {
  return 'Form(sId: $sId, school: $school, user: $user, interviewNote: $interviewNote, status: $status, application: $application, iV: $iV, amount: $amount, payment: $payment, paymentInfo: $paymentInfo, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FormCopyWith<$Res> implements $FormCopyWith<$Res> {
  factory _$FormCopyWith(_Form value, $Res Function(_Form) _then) = __$FormCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? sId,@JsonKey(name: 'schoolId') SchoolModel? school,@JsonKey(name: 'studId') User? user,@JsonKey(name: 'interviewNote') String? interviewNote,@FormStatusConverter() FormStatus? status,@JsonKey(name: 'applicationId') StudentApplication? application,@JsonKey(name: '__v') int? iV, int? amount,@StringOrPaymentStatusConverter() PaymentStatus? payment, Payment? paymentInfo,@DateTimeConverter() DateTime? createdAt,@DateTimeConverter() DateTime? updatedAt
});


@override $UserCopyWith<$Res>? get user;@override $PaymentCopyWith<$Res>? get paymentInfo;

}
/// @nodoc
class __$FormCopyWithImpl<$Res>
    implements _$FormCopyWith<$Res> {
  __$FormCopyWithImpl(this._self, this._then);

  final _Form _self;
  final $Res Function(_Form) _then;

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sId = freezed,Object? school = freezed,Object? user = freezed,Object? interviewNote = freezed,Object? status = freezed,Object? application = freezed,Object? iV = freezed,Object? amount = freezed,Object? payment = freezed,Object? paymentInfo = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Form(
sId: freezed == sId ? _self.sId : sId // ignore: cast_nullable_to_non_nullable
as String?,school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as SchoolModel?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,interviewNote: freezed == interviewNote ? _self.interviewNote : interviewNote // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus?,application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as StudentApplication?,iV: freezed == iV ? _self.iV : iV // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentStatus?,paymentInfo: freezed == paymentInfo ? _self.paymentInfo : paymentInfo // ignore: cast_nullable_to_non_nullable
as Payment?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentCopyWith<$Res>? get paymentInfo {
    if (_self.paymentInfo == null) {
    return null;
  }

  return $PaymentCopyWith<$Res>(_self.paymentInfo!, (value) {
    return _then(_self.copyWith(paymentInfo: value));
  });
}
}

// dart format on
