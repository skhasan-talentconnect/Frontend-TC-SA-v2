import 'package:flutter/material.dart' show BuildContext;
import 'package:tc_sa/core/network/app_failure.dart' show Failure;
import 'package:tc_sa/core/utils/toast.dart' show Toast;

extension FailureExt on Failure {
  bool get isExists => message != null && statusCode != null;

  void showError(BuildContext context) {
    if (statusCode != 500) {
      Toast.showErrorToast(context, message: message ?? 'Something Went Wrong');
    } else {
      print('Issue found: $message with $statusCode');
    }
  }
}
