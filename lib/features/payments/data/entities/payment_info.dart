import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_info.freezed.dart';
part 'payment_info.g.dart';

@freezed
abstract class PaymentInfo with _$PaymentInfo {
  const factory PaymentInfo({
    required int amount,
    @JsonKey(name: 'amount_due') required int amountDue,
    @JsonKey(name: 'amount_paid') required int amountPaid,
    required int attempts,
    @JsonKey(name: 'created_at') required int createdAt,
    required String currency,
    required String entity,
    required String id,
    required List<dynamic> notes,
    @JsonKey(name: 'offer_id') String? offerId,
    required String receipt,
    required String status,
  }) = _PaymentInfo;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);
}
