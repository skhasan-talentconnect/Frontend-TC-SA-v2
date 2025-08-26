import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/s_colors.dart';
import 'package:tc_sa/core/notifications/notification_service.dart';
import 'package:tc_sa/core/services/shared_pref_helper.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';
import 'package:tc_sa/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefHelper.init();
  await NotificationService().init();

  runApp(
    const MyApp(),
    //DevicePreview(builder: (context) => MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthView(),
      debugShowCheckedModeBanner: false,
      theme: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: SColor.backgroundColor),
    );
  }
}
