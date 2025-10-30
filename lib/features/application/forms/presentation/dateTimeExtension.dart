import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String get toEEEEDDMMMYYYY {
    try {
      return DateFormat('EEE, dd MMM yyyy').format(this);
    } catch (_) {
      return '-';
    }
  }

  String get toDDMMYYYY {
    try {
      return DateFormat('dd/MM/yyyy').format(this);
    } catch (_) {
      return '-';
    }
  }
}
