import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:insta_canvas/homeModule/provider/home_provider.dart';
import 'package:insta_canvas/theme_manager.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'ads/ad_state_provider.dart';
import 'authModule/provider/auth_provider.dart';
import 'authModule/screens/splash_screen.dart';
import 'historyModule/provider/history_provider.dart';
import 'navigation/navigation_service.dart';

final LocalStorage storage = LocalStorage('insta_canvas');

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider())
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true,
                  textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          title: 'InstaCanvas',
          theme: theme.getTheme,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: generateRoute,
          routes: {
            '/': (BuildContext context) => const SplashScreen(),
          },
        ),
      ),
    );
  }
}
