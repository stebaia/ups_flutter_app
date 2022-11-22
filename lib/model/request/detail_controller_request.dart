import 'package:ups_flutter_app/model/request/generic_request.dart';

class DetailControllerRequest {
  String? idController;
  String? token;
  DetailControllerRequest(this.token, this.idController);

  DetailControllerRequest.fromJson(Map<String, dynamic> json) {
    idController = json['id_controller'];
    this.token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id_controller'] = this.idController;
    return data;
  }
}
