import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:ups_flutter_app/network/skeleton_api.dart';
import 'package:ups_flutter_app/utils/app_exception.dart';
import 'package:ups_flutter_app/utils/secure_storage.dart';

import '../model/response/token_response.dart';
import '../model/response/user_login.dart';
import '../model/user.dart';

class NetworkService {
  final UserLogin user;
  bool isAlreadyCalled = false;
  NetworkService(this.user);

  Future<dynamic> networkCallWithToken(
      String endpoint, Map<String, dynamic> object) async {
    final response = await http.post(Uri.https(SkeletonApi.BASE_URL, endpoint),
        body: object);

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400 && !isAlreadyCalled) {
      isAlreadyCalled = true;
      final tokenResponse = await networkGetToken();
      if (tokenResponse.token != "") {
        Map<String, dynamic> objectToSend = object;
        objectToSend['token'] = tokenResponse.token;
        final apiResponse = await networkCallWithToken(endpoint, objectToSend);
        return apiResponse;
      } else {
        throw BadRequestException(response.reasonPhrase);
      }
    } else {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(response.reasonPhrase);
        case 401:
          throw UnauthorisedException(response.reasonPhrase);
        default:
          throw FetchDataException(response.reasonPhrase);
      }
    }
  }

  Future<User> networkGetToken() async {
    SecureStorage secureStorage = new SecureStorage();
    String? idOneSignal = await secureStorage.getOneSignalKeyFromStorage();
    Map<String, dynamic> bodyRequest = user.toMap();
    if (idOneSignal != null) {
      bodyRequest.addAll({'idPlayerOneSignal': idOneSignal});
    } else {
      final status = await OneSignal.shared.getDeviceState();
      final String? osUserID = status?.userId;
      bodyRequest.addAll({'idPlayerOneSignal': osUserID});
    }
    final response = await http.post(
        Uri.https(SkeletonApi.BASE_URL, SkeletonApi.TAKE_TOKEN),
        body: bodyRequest);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      TokenResponse tokenResponse =
          TokenResponse.fromJson(jsonDecode(response.body));
      User storedUser = User(
          email: user.email,
          password: user.password,
          token: tokenResponse.token!);
      SecureStorage secureStorage = SecureStorage();
      secureStorage.setUserInStorage(storedUser);
      return storedUser;
    } else {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(response.reasonPhrase);
        case 401:
          throw UnauthorisedException(response.reasonPhrase);
        default:
          throw FetchDataException(response.reasonPhrase);
      }
    }
  }
}
