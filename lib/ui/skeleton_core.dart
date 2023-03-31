import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ups_flutter_app/ui/splash_page.dart';
import 'package:ups_flutter_app/utils/theme_helper.dart';

import '../provider/bottom_navigation_bar_provider.dart';
import '../provider/dark_theme_provider.dart';

class SkeletonCore extends StatefulWidget {
  SkeletonCore({Key? key, required this.sharedPreferences}) : super(key: key);

  final SharedPreferences sharedPreferences;
  @override
  State<SkeletonCore> createState() => _SkeletonCoreState();
}

class _SkeletonCoreState extends State<SkeletonCore> {
  DarkThemeProvider themeProvider = new DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeProvider.darkTheme =
        await themeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("00787a2d-2fd9-4828-982a-4117513b5d6c");

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreenPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider<DarkThemeProvider>(create: (_) => themeProvider),
      ],
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blueGrey,
            fontFamily: 'Poppins'),
        title: "Skeleton App",
        routes: {
          "/": (context) => SplashScreenPage(),
        },
      ),
    );
  }
}
