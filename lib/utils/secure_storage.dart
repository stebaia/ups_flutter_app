import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  final String _userKey = "USER_KEY";

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
