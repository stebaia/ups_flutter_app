class DetailUpsRequest {
  String? idController;
  String? token;
  String? idUps;

  DetailUpsRequest(this.token, this.idController, this.idUps);

  DetailUpsRequest.fromJson(Map<String, dynamic> json) {
    idController = json['id_controller'];
    token = json['token'];
    idUps = json['id_ups'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id_controller'] = this.idController;
    data['id_ups'] = this.idUps;
    return data;
  }
}
