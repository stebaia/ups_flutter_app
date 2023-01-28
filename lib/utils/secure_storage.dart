import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  final String _userKey = "USER_KEY";
  final String _oneSignalKey = "ONE_SIGNAL_KEY";

  Future setOneSignalKeyInStorage(String key) async {
    await storage.write(key: _oneSignalKey, value: key);
  }

  Future<void> deleteOneSignalKeySecureData() async {
    await storage.delete(
      key: _oneSignalKey,
    );
  }

  Future<String?> getOneSignalKeyFromStorage() async {
    try {
      return await storage.read(key: _oneSignalKey);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future setUserInStorage(User user) async {
    await storage.write(key: _userKey, value: json.encode(user));
  }

  Future<void> deleteSecureData() async {
    await storage.delete(
      key: _userKey,
    );
  }

  Future<String?> getUserFromStorage() async {
    try {
      return await storage.read(key: _userKey);
    } catch (e) {
      throw Exception(e);
    }
  }
}
