import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/features/notifications/presentation/index.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationViewModel notificationViewModel = NotificationViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await notificationViewModel.getNotifications(
        notify: true,
      );
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: notificationViewModel,
      child: Scaffold(
        appBar: SAppBar(
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () {
              context.pop();
            },
            color: SColor.secTextColor,
          ),
          title: 'Notifications',
          actions: [
            Consumer<NotificationViewModel>(
              builder:
                  (_, vm, __) => SIcon(
                    padding: EdgeInsets.only(right: 4),
                    image: Text(
                      'Mark all as read',
                      style: STextStyles.s12W600.copyWith(
                        color:
                            vm.isLoading
                                ? SColor.backgroundColor
                                : vm.isUnreadNotificationPresent
                                ? SColor.secTextColor
                                : SColor.terTextColor.withOpacity(0.5),
                      ),
                    ),
                    onTap:
                        vm.isLoading
                            ? null
                            : vm.isUnreadNotificationPresent
                            ? () async {
                              final failure =
                                  await notificationViewModel.markAllAsRead();
                              failure?.showError(context);
                            }
                            : null,
                  ),
            ),
          ],
        ),

        body: Consumer<NotificationViewModel>(
          builder: (vmContext, vm, _) {
            if (vm.isLoading) {
              return Center(child: SLoadingIndicator());
            }

            if (vm.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No notifications available',
                      style: STextStyles.s16W400,
                    ),
                    const SizedBox(
                      height: kToolbarHeight + (kToolbarHeight / 2),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                final failure = await notificationViewModel.getNotifications(
                  notify: true,
                );
                failure?.showError(context);
              },
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: vm.notifications.length,
                separatorBuilder: (_, __) => SizedBox(height: 8),
                itemBuilder:
                    (_, index) => NotificationItem(
                      notification: vm.notifications[index],
                      onTap: () async {
                        final failure = await notificationViewModel.markAsRead(
                          notificationId: vm.notifications[index].sId ?? '',
                        );
                        failure?.showError(context);
                      },
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
