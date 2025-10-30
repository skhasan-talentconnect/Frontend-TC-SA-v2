import 'package:flutter/material.dart' hide Notification; 
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/features/notifications/data/entities/notification.dart';
class NotificationDetailView extends StatelessWidget {
  final Notification notification;

  const NotificationDetailView({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: notification.title ?? 'Notification Detail',
        leading: SIcon(
          icon: Icons.arrow_back_ios_new,
          onTap: () => Navigator.pop(context),
          color: SColor.secTextColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SColor.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: SColor.secTextColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                notification.title ?? 'No title',
                style: STextStyles.s16W600,
              ),
              const SizedBox(height: 8),

              // Timestamp
              Text(
                notification.createdAt ?? '',
                style: STextStyles.s12W400.copyWith(
                  color: SColor.terTextColor,
                ),
              ),
              const SizedBox(height: 16),

              // Body
              Text(
                notification.body ?? 'No content available.',
                style: STextStyles.s14W400.copyWith(
                  color: SColor.secTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
