// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentInfo {

 int get amount;@JsonKey(name: 'amount_due') int get amountDue;@JsonKey(name: 'amount_paid') int get amountPaid; int get attempts;@JsonKey(name: 'created_at') int get createdAt; String get currency; String get entity; String get id; List<dynamic> get notes;@JsonKey(name: 'offer_id') String? get offerId; String get receipt; String get status;
/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentInfoCopyWith<PaymentInfo> get copyWith => _$PaymentInfoCopyWithImpl<PaymentInfo>(this as PaymentInfo, _$identity);

  /// Serializes this PaymentInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentInfo&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountDue, amountDue) || other.amountDue == amountDue)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,amountDue,amountPaid,attempts,createdAt,currency,entity,id,const DeepCollectionEquality().hash(notes),offerId,receipt,status);

@override
String toString() {
  return 'PaymentInfo(amount: $amount, amountDue: $amountDue, amountPaid: $amountPaid, attempts: $attempts, createdAt: $createdAt, currency: $currency, entity: $entity, id: $id, notes: $notes, offerId: $offerId, receipt: $receipt, status: $status)';
}


}

/// @nodoc
abstract mixin class $PaymentInfoCopyWith<$Res>  {
  factory $PaymentInfoCopyWith(PaymentInfo value, $Res Function(PaymentInfo) _then) = _$PaymentInfoCopyWithImpl;
@useResult
$Res call({
 int amount,@JsonKey(name: 'amount_due') int amountDue,@JsonKey(name: 'amount_paid') int amountPaid, int attempts,@JsonKey(name: 'created_at') int createdAt, String currency, String entity, String id, List<dynamic> notes,@JsonKey(name: 'offer_id') String? offerId, String receipt, String status
});




}
/// @nodoc
class _$PaymentInfoCopyWithImpl<$Res>
    implements $PaymentInfoCopyWith<$Res> {
  _$PaymentInfoCopyWithImpl(this._self, this._then);

  final PaymentInfo _self;
  final $Res Function(PaymentInfo) _then;

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? amountDue = null,Object? amountPaid = null,Object? attempts = null,Object? createdAt = null,Object? currency = null,Object? entity = null,Object? id = null,Object? notes = null,Object? offerId = freezed,Object? receipt = null,Object? status = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,amountDue: null == amountDue ? _self.amountDue : amountDue // ignore: cast_nullable_to_non_nullable
as int,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as int,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<dynamic>,offerId: freezed == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String?,receipt: null == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentInfo].
extension PaymentInfoPatterns on PaymentInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentInfo value)  $default,){
final _that = this;
switch (_that) {
case _PaymentInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount, @JsonKey(name: 'amount_due')  int amountDue, @JsonKey(name: 'amount_paid')  int amountPaid,  int attempts, @JsonKey(name: 'created_at')  int createdAt,  String currency,  String entity,  String id,  List<dynamic> notes, @JsonKey(name: 'offer_id')  String? offerId,  String receipt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
return $default(_that.amount,_that.amountDue,_that.amountPaid,_that.attempts,_that.createdAt,_that.currency,_that.entity,_that.id,_that.notes,_that.offerId,_that.receipt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount, @JsonKey(name: 'amount_due')  int amountDue, @JsonKey(name: 'amount_paid')  int amountPaid,  int attempts, @JsonKey(name: 'created_at')  int createdAt,  String currency,  String entity,  String id,  List<dynamic> notes, @JsonKey(name: 'offer_id')  String? offerId,  String receipt,  String status)  $default,) {final _that = this;
switch (_that) {
case _PaymentInfo():
return $default(_that.amount,_that.amountDue,_that.amountPaid,_that.attempts,_that.createdAt,_that.currency,_that.entity,_that.id,_that.notes,_that.offerId,_that.receipt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount, @JsonKey(name: 'amount_due')  int amountDue, @JsonKey(name: 'amount_paid')  int amountPaid,  int attempts, @JsonKey(name: 'created_at')  int createdAt,  String currency,  String entity,  String id,  List<dynamic> notes, @JsonKey(name: 'offer_id')  String? offerId,  String receipt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
return $default(_that.amount,_that.amountDue,_that.amountPaid,_that.attempts,_that.createdAt,_that.currency,_that.entity,_that.id,_that.notes,_that.offerId,_that.receipt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentInfo implements PaymentInfo {
  const _PaymentInfo({required this.amount, @JsonKey(name: 'amount_due') required this.amountDue, @JsonKey(name: 'amount_paid') required this.amountPaid, required this.attempts, @JsonKey(name: 'created_at') required this.createdAt, required this.currency, required this.entity, required this.id, required final  List<dynamic> notes, @JsonKey(name: 'offer_id') this.offerId, required this.receipt, required this.status}): _notes = notes;
  factory _PaymentInfo.fromJson(Map<String, dynamic> json) => _$PaymentInfoFromJson(json);

@override final  int amount;
@override@JsonKey(name: 'amount_due') final  int amountDue;
@override@JsonKey(name: 'amount_paid') final  int amountPaid;
@override final  int attempts;
@override@JsonKey(name: 'created_at') final  int createdAt;
@override final  String currency;
@override final  String entity;
@override final  String id;
 final  List<dynamic> _notes;
@override List<dynamic> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override@JsonKey(name: 'offer_id') final  String? offerId;
@override final  String receipt;
@override final  String status;

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentInfoCopyWith<_PaymentInfo> get copyWith => __$PaymentInfoCopyWithImpl<_PaymentInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentInfo&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountDue, amountDue) || other.amountDue == amountDue)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,amountDue,amountPaid,attempts,createdAt,currency,entity,id,const DeepCollectionEquality().hash(_notes),offerId,receipt,status);

@override
String toString() {
  return 'PaymentInfo(amount: $amount, amountDue: $amountDue, amountPaid: $amountPaid, attempts: $attempts, createdAt: $createdAt, currency: $currency, entity: $entity, id: $id, notes: $notes, offerId: $offerId, receipt: $receipt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PaymentInfoCopyWith<$Res> implements $PaymentInfoCopyWith<$Res> {
  factory _$PaymentInfoCopyWith(_PaymentInfo value, $Res Function(_PaymentInfo) _then) = __$PaymentInfoCopyWithImpl;
@override @useResult
$Res call({
 int amount,@JsonKey(name: 'amount_due') int amountDue,@JsonKey(name: 'amount_paid') int amountPaid, int attempts,@JsonKey(name: 'created_at') int createdAt, String currency, String entity, String id, List<dynamic> notes,@JsonKey(name: 'offer_id') String? offerId, String receipt, String status
});




}
/// @nodoc
class __$PaymentInfoCopyWithImpl<$Res>
    implements _$PaymentInfoCopyWith<$Res> {
  __$PaymentInfoCopyWithImpl(this._self, this._then);

  final _PaymentInfo _self;
  final $Res Function(_PaymentInfo) _then;

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? amountDue = null,Object? amountPaid = null,Object? attempts = null,Object? createdAt = null,Object? currency = null,Object? entity = null,Object? id = null,Object? notes = null,Object? offerId = freezed,Object? receipt = null,Object? status = null,}) {
  return _then(_PaymentInfo(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,amountDue: null == amountDue ? _self.amountDue : amountDue // ignore: cast_nullable_to_non_nullable
as int,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as int,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<dynamic>,offerId: freezed == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String?,receipt: null == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
