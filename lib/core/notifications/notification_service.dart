import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tc_sa/core/services/shared_pref_helper.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    // Request permissions
    await _fcm.requestPermission();
    String? fcmToken = await _fcm.getToken();

    SharedPrefHelper.setString("deviceToken", fcmToken ?? '');

    // Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Foreground notification: ${message.notification?.title}');

      _flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'Default Channel',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    });

    // When opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("🔄 Opened from background");
      // Handle routing here
    });

    // When opened from terminated state
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      print("🚀 Opened from terminated");
      // Handle initial notification
    }
  }
}
