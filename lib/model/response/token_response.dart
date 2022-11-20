class TokenResponse {
  String? status;
  String? token;
  int? code;

  TokenResponse({this.status, this.token, this.code});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['code'] = this.code;
    return data;
  }
}
