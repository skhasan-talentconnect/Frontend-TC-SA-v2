enum PaymentStatus { paid, unpaid }

extension PaymentStatusExt on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.unpaid:
        return 'Unpaid';
    }
  }

  static PaymentStatus fromValue(String value) {
    switch (value) {
      case 'Paid':
        return PaymentStatus.paid;
      case 'Unpaid':
        return PaymentStatus.unpaid;
      default:
        throw ArgumentError('Invalid PaymentStatus value: $value');
    }
  }
}
