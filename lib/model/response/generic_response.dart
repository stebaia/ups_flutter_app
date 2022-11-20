class GenericResponse {
  String? status;
  int? code;

  GenericResponse({this.status, this.code});

  GenericResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}
