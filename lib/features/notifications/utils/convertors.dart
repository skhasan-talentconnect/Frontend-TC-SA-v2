import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/features/notifications/utils/enums.dart';

class NotificationTypeConverter
    implements JsonConverter<NotificationType, String> {
  const NotificationTypeConverter();

  @override
  NotificationType fromJson(String json) => NotificationTypeExt.fromLabel(json);

  @override
  String toJson(NotificationType object) => object.label;
}
