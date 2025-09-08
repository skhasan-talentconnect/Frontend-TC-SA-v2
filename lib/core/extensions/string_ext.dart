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

  String get toCapitalise {
    final String string = this;
    final newString = string.replaceFirst(
      string[0] ?? '',
      (string[0] ?? '').toUpperCase(),
    );
    return newString;
  }
}
