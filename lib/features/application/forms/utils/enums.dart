import 'package:flutter/material.dart';

enum FormStatus { pending, reviewed, accepted, rejected }

extension FormStatusExt on FormStatus {
  String get label {
    switch (this) {
      case FormStatus.pending:
        return 'Pending';
      case FormStatus.reviewed:
        return 'Reviewed';
      case FormStatus.accepted:
        return 'Accepted';
      case FormStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case FormStatus.pending:
        return Colors.grey.shade700;
      case FormStatus.reviewed:
        return Colors.yellow.shade700;
      case FormStatus.accepted:
        return Colors.green;
      case FormStatus.rejected:
        return Colors.red;
    }
  }

  static FormStatus fromApiValue(String value) {
    switch (value) {
      case 'Reviewed':
        return FormStatus.reviewed;
      case 'Accepted':
        return FormStatus.accepted;
      case 'Rejected':
        return FormStatus.rejected;
      case 'Pending':
      default:
        return FormStatus.pending;
    }
  }
}
