import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/features/notifications/utils/convertors.dart';
import 'package:tc_sa/features/notifications/utils/enums.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    @JsonKey(name: '_id') String? sId,
    String? authId,
    String? title,
    String? body,
    String? path,
    @NotificationTypeConverter() NotificationType? notificationType,
    @JsonKey(name: 'is_read') bool? isRead,
    Map<String, dynamic>? data,
    String? createdAt,
    String? updatedAt,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
