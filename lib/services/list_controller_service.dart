import 'dart:convert';

import 'package:ups_flutter_app/model/controller.dart';
import 'package:ups_flutter_app/model/request/generic_request.dart';
import 'package:ups_flutter_app/model/response/list_controller_response.dart';
import 'package:ups_flutter_app/network/skeleton_api.dart';
import 'package:ups_flutter_app/services/network_service.dart';
import 'package:ups_flutter_app/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../utils/app_exception.dart';

class ListControllerService extends NetworkService {
  ListControllerService(super.user);

  Future<ListControllerResponse> fetchControllerResponse() async {
    SecureStorage secureStorage = SecureStorage();
    return await secureStorage.getUserFromStorage().then((user) async {
      User convertedUser = User.fromMap(json.decode(user!));
      final notConvertedResponse = await networkCallWithToken(
          SkeletonApi.LIST_CONTROLLERS,
          (GenericRequest(token: convertedUser.token).toJson()));
      http.Response response = notConvertedResponse as http.Response;
      if (response.statusCode == 200) {
        return ListControllerResponse.fromJson(jsonDecode(response.body));
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
    });
  }
}
