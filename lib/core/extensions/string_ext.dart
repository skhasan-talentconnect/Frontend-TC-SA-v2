import 'package:intl/intl.dart';

extension StringExt on String {
  String get toRelativeTime {
    DateTime date;
    try {
      date = DateTime.parse(this).toUtc();
    } catch (e) {
      return this; // return original if not parsable
    }

    final now = DateTime.now().toUtc();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return "now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays}d ago";
    } else {
      // Format date depending on year
      final sameYearFormatter = DateFormat("d MMM");
      final diffYearFormatter = DateFormat("d MMM yyyy");

      if (date.year == now.year) {
        return sameYearFormatter.format(date);
      } else {
        return diffYearFormatter.format(date);
      }
    }
  }

  DateTime get toDate {
    DateTime date = DateTime.parse(this);
    return date;
  }

  String get toDDMMYYYY {
    DateTime date = toDate;
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String get toYYYYY {
    DateTime date = toDate;
    return DateFormat('yyyy').format(date);
  }

  String get toEEEEDDMMMYYYY {
    DateTime date = toDate;
    return DateFormat('EEEE, dd MMM yyyy').format(date);
  }

  String get toCapitalise {
    final String string = this;
    final newString = string.replaceFirst(
      string[0] ?? '',
      (string[0] ?? '').toUpperCase(),
    );
    return newString;
  }

  String get toCardFess {
    final String string = this;
    switch (string) {
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
        return '5L+ ';
    }
  }
}
