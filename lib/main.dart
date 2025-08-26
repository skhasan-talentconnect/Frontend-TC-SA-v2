import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/s_colors.dart';
import 'package:tc_sa/core/notifications/notification_service.dart';
import 'package:tc_sa/core/services/shared_pref_helper.dart';
import 'package:tc_sa/features/blogs/blogs_view.dart';
import 'package:tc_sa/features/predictor/predictor_view.dart';
import 'package:tc_sa/features/reviews/review.dart';
import 'package:tc_sa/features/users/shortlist/shortlist_view.dart';
import 'package:tc_sa/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefHelper.init();
  await NotificationService().init();
  initServiceLocator();
  await getIt.allReady();

  runApp(
    const MyApp(),
    //DevicePreview(builder: (context) => MyApp()),
  );
}

final router = AppRouter().router;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    return MaterialApp(
      home: ShortlistedSchoolsPage(),
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
