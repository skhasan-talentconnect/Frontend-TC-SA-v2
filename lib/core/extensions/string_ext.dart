import 'package:intl/intl.dart';

extension StringExt on String {
  /// Safely converts the string to DateTime with multiple fallback formats.
  DateTime? get toDate {
    if (isEmpty) return null;
    try {
      // ✅ Works for "2025-10-30T12:34:56.000Z"
      return DateTime.parse(this).toLocal();
    } catch (_) {
      try {
        // ✅ Works for "2025-10-30 12:34:56"
        return DateFormat("yyyy-MM-dd HH:mm:ss").parse(this, true).toLocal();
      } catch (_) {
        try {
          // ✅ Works for "30/10/2025"
          return DateFormat("dd/MM/yyyy").parse(this, true).toLocal();
        } catch (_) {
          return null; // ❌ if nothing works
        }
      }
    }
  }

  /// Relative time like "5m ago", "2d ago"
  String get toRelativeTime {
    final date = toDate;
    if (date == null) return this; // fallback

    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return "now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";

    final sameYearFormatter = DateFormat("d MMM");
    final diffYearFormatter = DateFormat("d MMM yyyy");

    return (date.year == now.year)
        ? sameYearFormatter.format(date)
        : diffYearFormatter.format(date);
  }

  /// Converts to dd/MM/yyyy (e.g. "30/10/2025")
  String get toDDMMYYYY {
    final date = toDate;
    if (date == null) return this;
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Converts to yyyy (e.g. "2025")
  String get toYYYYY {
    final date = toDate;
    if (date == null) return this;
    return DateFormat('yyyy').format(date);
  }

  /// Converts to EEEE, dd MMM yyyy (e.g. "Thursday, 30 Oct 2025")
  String get toEEEEDDMMMYYYY {
    final date = toDate;
    if (date == null) return this;
    return DateFormat('EEEE, dd MMM yyyy').format(date);
  }

  /// Capitalises first letter
  String get toCapitalise {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Converts card fee ranges to short display versions
  String get toCardFess {
    switch (this) {
      case "1000 - 10000":
        return '1K - 10K';
      case "10000 - 25000":
        return '10K - 25K';
      case "25000 - 50000":
        return '25K - 50K';
      case "50000 - 75000":
        return '50K - 75K';
      case "75000 - 100000":
        return '75K - 1L';
      case "1 Lakh - 2 Lakh":
        return '1L - 2L';
      case "2 Lakh - 3 Lakh":
        return '2L - 3L';
      case "3 Lakh - 4 Lakh":
        return '3L - 4L';
      case "4 Lakh - 5 Lakh":
        return '4L - 5L';
      default:
        return '5L+';
    }
  }
}
