// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => _PaymentInfo(
  amount: (json['amount'] as num).toInt(),
  amountDue: (json['amount_due'] as num).toInt(),
  amountPaid: (json['amount_paid'] as num).toInt(),
  attempts: (json['attempts'] as num).toInt(),
  createdAt: (json['created_at'] as num).toInt(),
  currency: json['currency'] as String,
  entity: json['entity'] as String,
  id: json['id'] as String,
  notes: json['notes'] as List<dynamic>,
  offerId: json['offer_id'] as String?,
  receipt: json['receipt'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$PaymentInfoToJson(_PaymentInfo instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'amount_due': instance.amountDue,
      'amount_paid': instance.amountPaid,
      'attempts': instance.attempts,
      'created_at': instance.createdAt,
      'currency': instance.currency,
      'entity': instance.entity,
      'id': instance.id,
      'notes': instance.notes,
      'offer_id': instance.offerId,
      'receipt': instance.receipt,
      'status': instance.status,
    };
