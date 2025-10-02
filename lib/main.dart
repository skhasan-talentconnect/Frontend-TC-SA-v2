import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/s_colors.dart';
import 'package:tc_sa/core/notifications/notification_service.dart';
import 'package:tc_sa/core/services/shared_pref_helper.dart';
import 'package:tc_sa/firebase_options.dart';

import 'core/navigation/router.dart';
import 'core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefHelper.init();
  await NotificationService().init();
  initServiceLocator();
  await getIt.allReady();

  if (kIsWeb) {
    runApp(
      //const MyApp(),
      DevicePreview(builder: (context) => MyApp()),
    );
  } else {
    runApp(
      const MyApp(),
      //DevicePreview(builder: (context) => MyApp()),
    );
  }
}

final router = AppRouter().router;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      theme: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: SColor.backgroundColor),
    );
  }
}
