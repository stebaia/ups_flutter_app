import 'package:ups_flutter_app/model/upsDetail.dart';

class UpsDetailResponse {
  String? status;
  UpsDetail? data;
  int? code;

  UpsDetailResponse({this.status, this.data, this.code});

  UpsDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UpsDetail.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}
