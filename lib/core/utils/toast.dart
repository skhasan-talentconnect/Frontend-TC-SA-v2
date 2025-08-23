import 'package:flutter/material.dart';

class Toast {
  static void showErrorToast(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        showCloseIcon: true,
        closeIconColor: Colors.black,
      ),
    );
  }

  static void showSuccessToast(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
    );
  }

  static void showInfoToast(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.error_outline, color: Colors.black),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.yellow,
        showCloseIcon: true,
        closeIconColor: Colors.black,
      ),
    );
  }
}
