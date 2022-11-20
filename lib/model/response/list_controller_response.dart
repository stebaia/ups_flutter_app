import 'package:ups_flutter_app/model/controller.dart';
import 'package:ups_flutter_app/model/response/generic_response.dart';

class ListControllerResponse extends GenericResponse {
  List<Controller>? controllers;

  ListControllerResponse({required this.controllers});

  ListControllerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['controllers'] != null) {
      controllers = <Controller>[];
      json['controllers'].forEach((v) {
        controllers!.add(new Controller.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.controllers != null) {
      data['controllers'] = this.controllers!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}
