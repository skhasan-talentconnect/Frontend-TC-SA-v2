import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/utils/no_internet_view.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefHelper.init();
  await NotificationService().init();
  initServiceLocator();
  await getIt.allReady();

  final Widget wrappedApp = MultiProvider(
    providers: [
      // Add any other existing providers here
      // For example: ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ChangeNotifierProvider(create: (_) => ShortlistNotificationProvider()),
    ],
    child: const MyApp(),
  );

  if (kIsWeb) {
    runApp(
      // 4. Use the wrappedApp in DevicePreview
      DevicePreview(builder: (context) => wrappedApp),
    );
  } else {
    // 5. Use the wrappedApp for mobile
    runApp(wrappedApp);
  }
}

final router = AppRouter().router;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<ConnectivityProvider>()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ConnectivityProvider>(
        builder: (vmContext, connectivityProvider, child) {
          final colors = vmContext.watch<ThemeProvider>().colors;

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            theme: ThemeData(scaffoldBackgroundColor: colors.backgroundColor),
            builder: (context, child) {
              if (connectivityProvider.status == NetworkStatus.onlineSlow) {
                Toasts.showInfoToast(
                  context,
                  message:
                      'Slow internet connection detected. It can affect app\'s behaviour',
                );
              }
              if (connectivityProvider.status == NetworkStatus.offline) {
                return const NoInternetView();
              }

              return child!;
            },
          );
        },
      ),
    );
  }
}
