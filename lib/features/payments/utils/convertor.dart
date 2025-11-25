import 'package:freezed_annotation/freezed_annotation.dart';

import 'enum.dart';

class StringOrPaymentStatusConverter
    implements JsonConverter<PaymentStatus, String> {
  const StringOrPaymentStatusConverter();

  @override
  PaymentStatus fromJson(String json) {
    return PaymentStatusExt.fromValue(json);
  }

  @override
  String toJson(PaymentStatus object) {
    return object.label;
  }
}
