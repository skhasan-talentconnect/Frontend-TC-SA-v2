import 'package:flutter/material.dart';

enum NotificationType {
  discovery,
  accepted,
  rejected,
  review,
  submitted,
  others,
}

extension NotificationTypeExt on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.discovery:
        return 'Discovery';
      case NotificationType.accepted:
        return 'Accepted';
      case NotificationType.rejected:
        return 'Rejected';
      case NotificationType.review:
        return 'Reviewed';
      case NotificationType.submitted:
        return 'Submitted';
      case NotificationType.others:
        return 'Others';
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.discovery:
        return Colors.orange;
      case NotificationType.accepted:
        return Colors.green;
      case NotificationType.rejected:
        return Colors.red;
      case NotificationType.review:
        return Colors.yellow.shade700;
      case NotificationType.submitted:
        return Colors.blue;
      case NotificationType.others:
        return Colors.grey.shade700;
    }
  }

  Icon get icon {
    switch (this) {
      case NotificationType.discovery:
        return Icon(Icons.language, color: Colors.white);
      case NotificationType.accepted:
        return Icon(Icons.check, color: Colors.white);
      case NotificationType.rejected:
        return Icon(Icons.close, color: Colors.white);
      case NotificationType.review:
        return Icon(Icons.reviews, color: Colors.white);
      case NotificationType.submitted:
        return Icon(Icons.approval, color: Colors.white);
      case NotificationType.others:
        return Icon(Icons.more_horiz, color: Colors.white);
    }
  }

  static NotificationType fromLabel(String value) {
    switch (value) {
      case 'Accepted':
        return NotificationType.accepted;
      case 'Rejected':
        return NotificationType.rejected;
      case 'Reviewed':
        return NotificationType.review;
      case 'Submitted':
        return NotificationType.submitted;
      case 'Discovery':
        return NotificationType.discovery;
      default:
        return NotificationType.others;
    }
  }
}
