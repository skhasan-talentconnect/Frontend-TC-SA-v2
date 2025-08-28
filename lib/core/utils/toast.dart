import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart' show STextStyles;
import 'package:tc_sa/core/index.dart';

class Toasts {
  static OverlayEntry? currEntry;

  static void _showToast(
    BuildContext context, {
    required String message,
    required Color backgroundClr,
    required Border border,
    required IconData icon,
  }) {
    final overlay = Overlay.of(context); // just

    if (currEntry != null) return;

    // Animation controller
    AnimationController controller = AnimationController(
      vsync: Navigator.of(context),
      duration: Duration(milliseconds: 300),
    );

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top, // below status bar
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -1),
                end: Offset(0, 0),
              ).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOut),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: backgroundClr,
                  borderRadius: BorderRadius.circular(8),
                  border: border,
                ),
                child: Row(
                  children: [
                    Icon(icon, size: 32, color: Colors.black),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: STextStyles.s14W400.copyWith(
                          color: Colors.black,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
    currEntry = overlayEntry;
    controller.forward();

    Future.delayed(Duration(seconds: 4), () {
      controller.reverse().then((_) {
        currEntry = null;
        overlayEntry.remove();
      });
    });
  }

  static void showInfoToast(BuildContext context, {required String message}) {
    _showToast(
      context,
      message: message,
      backgroundClr: Colors.yellow.shade100,
      border: Border.all(color: Colors.orange, width: 1.5),
      icon: Icons.info_outline,
    );
  }

  static void showErrorToast(BuildContext context, {required String message}) {
    _showToast(
      context,
      message: message,
      backgroundClr: Colors.pink.shade100,
      border: Border.all(color: Colors.red, width: 2),
      icon: Icons.error_outline,
    );
  }

  static void showSuccessToast(
    BuildContext context, {
    required String message,
  }) {
    _showToast(
      context,
      message: message,
      backgroundClr: Colors.green.shade100,
      border: Border.all(color: Colors.green.shade700, width: 2),
      icon: Icons.check,
    );
  }

  static void showSuccessOrFailureToast(
    BuildContext context, {
    Failure? failure,
    String? failureMsg,
    VoidCallback? failureCallback,
    bool popOnFailure = false,
    bool popOnSuccess = true,
    String? successMsg,
    String? successTitle,
    VoidCallback? successCallback,
  }) {
    if (failure == null) {
      Toasts.showSuccessToast(
        context,
        message: successMsg ?? 'Api Hit Successfully',
      );

      if (successCallback != null) {
        successCallback();
      }

      if (popOnSuccess) {
        context.pop(true);
      }
    } else {
      Toasts.showErrorToast(
        context,
        message: failureMsg ?? (failure.message ?? 'API hit Failed'),
      );

      if (failureCallback != null) {
        failureCallback();
      }

      if (popOnFailure) {
        context.pop(true);
      }
    }
  }
}
