import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ups_flutter_app/ui/skeleton_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  //Remove this method to stop OneSignal Debugging

  runApp(SkeletonCore(
    sharedPreferences: sharedPreferences,
  ));
}
