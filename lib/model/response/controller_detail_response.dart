import 'package:ups_flutter_app/model/response/generic_response.dart';

import '../controller.dart';

class ControllerResponse extends GenericResponse {
  Controller? controller;

  ControllerResponse({this.controller});

  ControllerResponse.fromJson(Map<String, dynamic> json) {
    controller = json['controller'] != null
        ? new Controller.fromJson(json['controller'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.controller != null) {
      data['controller'] = this.controller!.toJson();
    }
    return data;
  }
}
