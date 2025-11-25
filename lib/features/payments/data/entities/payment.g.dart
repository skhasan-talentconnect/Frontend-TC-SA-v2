// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  orderId: json['order_id'] as String?,
  paymentId: json['payment_id'] as String?,
  signature: json['signature'] as String?,
  status: json['status'] as String,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'order_id': instance.orderId,
  'payment_id': instance.paymentId,
  'signature': instance.signature,
  'status': instance.status,
};
