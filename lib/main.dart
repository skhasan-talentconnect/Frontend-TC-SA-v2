import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/theme/s_colors.dart';
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
    return ChangeNotifierProvider.value(
      value: getIt<ConnectivityProvider>(),
      child: Consumer<ConnectivityProvider>(
        builder:
            (_, connectivityProvider, child) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              theme: Theme.of(
                context,
              ).copyWith(scaffoldBackgroundColor: SColor.backgroundColor),
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
            ),
      ),
    );
  }
}
