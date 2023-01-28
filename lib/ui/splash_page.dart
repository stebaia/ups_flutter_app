import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ups_flutter_app/ui/home_page.dart';
import 'package:ups_flutter_app/ui/login_page.dart';
import 'package:ups_flutter_app/utils/secure_storage.dart';

import '../model/user.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    loadSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future loadSplash() async {
    SecureStorage secureStorage = SecureStorage();
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("00787a2d-2fd9-4828-982a-4117513b5d6c");

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    String? userToMap = await secureStorage.getUserFromStorage();
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    secureStorage.setOneSignalKeyInStorage(osUserID!);
    if (userToMap != null) {
      User user = User.fromMap(json.decode(userToMap));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => HomePageScreen(
                    user: user,
                  ))));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => LoginPageScreen())));
    }
  }
}
