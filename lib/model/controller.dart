import 'package:ups_flutter_app/model/ups.dart';

class Controller {
  int? id;
  String? name;
  String? status;
  String? lastCheck;
  String? ipPublic;
  String? ipVpn;
  String? connection;
  List<Ups>? ups;

  Controller(
      {this.id,
      this.name,
      this.status,
      this.lastCheck,
      this.ipPublic,
      this.ipVpn,
      this.connection});

  Controller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    lastCheck = json['last_check'];
    ipPublic = json['ip_public'];
    ipVpn = json['ip_vpn'];
    connection = json['connection'];
    if (json['ups'] != null) {
      ups = <Ups>[];
      json['ups'].forEach((v) {
        ups!.add(new Ups.fromJson(v));
      });
    } else {
      ups = <Ups>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['last_check'] = this.lastCheck;
    data['ip_public'] = this.ipPublic;
    data['ip_vpn'] = this.ipVpn;
    data['connection'] = this.connection;
    if (this.ups != null) {
      data['ups'] = this.ups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
