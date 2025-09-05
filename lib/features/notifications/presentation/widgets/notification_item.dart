import 'package:flutter/material.dart' hide Notification;
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/index.dart';
import 'package:tc_sa/features/notifications/utils/enums.dart';

import '../../data/entities/notification.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({required this.notification, this.onTap, super.key});

  final Notification notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: SColor.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: SColor.secTextColor.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          spacing: 12,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color:
                    (notification.notificationType ?? NotificationType.others)
                        .color,
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  (notification.notificationType ?? NotificationType.others)
                      .icon,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title ?? '',
                          style: STextStyles.s12W600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              notification.isRead ?? false
                                  ? SColor.backgroundColor
                                  : SColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Text(
                          notification.body ?? '',
                          style: STextStyles.s12W400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        (notification.createdAt ?? '').toRelativeTime,
                        style: STextStyles.s10W600.copyWith(
                          color: SColor.terTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
