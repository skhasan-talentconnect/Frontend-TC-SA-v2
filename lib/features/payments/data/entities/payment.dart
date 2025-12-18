import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    @JsonKey(name: 'order_id') String? orderId,
    @JsonKey(name: 'payment_id') String? paymentId,
    @JsonKey(name: 'signature') String? signature,
    required String status, // captured / failed
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
