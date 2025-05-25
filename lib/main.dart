import 'dart:async';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tractorapp/src/core/providers/shared_preferences/shared_preference_provider.dart';
import 'package:tractorapp/src/core/router/config/router_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // Initialize Firebase with options
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await FastCachedImageConfig.init(
    clearCacheAfter: const Duration(days: 3),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  await dotenv.load();

  // Use the container to initialize the app
  runApp(
    ProviderScope(
      overrides: [
        // override the previous value with the new object
        sharedPreferenceInstanceProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // final NotificationManager _notificationManager =
  //     NotificationManager(navigatorKey);

  @override
  void initState() {
    super.initState();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    ref.read(isLoggedInPreferenceProvider);
    ref.read(userNamePreferenceProvider);
    ref.read(userIdPreferenceProvider);
    ref.read(tokenPreferenceProvider);
    ref.read(phoneNumberPreferenceProvider);
    // TODO: Uncomment this when we have a way to check for updates
    // checkForUpdate(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return OverlaySupport(
        child: MaterialApp.router(
          routeInformationProvider:
              ref.read(routerProvider).routeInformationProvider,
          routeInformationParser:
              ref.read(routerProvider).routeInformationParser,
          routerDelegate: ref.read(routerProvider).routerDelegate,
          debugShowCheckedModeBanner: false,
          title: 'MazaoHub',
          themeMode: ThemeMode.system,
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    // ref.read(notificationManagerProvider).dispose();
  }
}
