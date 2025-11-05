import 'package:flutter/material.dart';

enum FormStatus { pending, reviewed, accepted, rejected, interview }

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
      case FormStatus.interview:
        return 'Interview';
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
      case FormStatus.interview:
        return Colors.blue.shade700;
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
      case 'Interview':
        return FormStatus.interview;
      case 'Pending':
      default:
        return FormStatus.pending;
    }
  }
}
