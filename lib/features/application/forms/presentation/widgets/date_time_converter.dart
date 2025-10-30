import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is DateTime) return json;
    if (json is String && json.isNotEmpty) {
      try {
        return DateTime.parse(json);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? date) => date?.toIso8601String();
}
