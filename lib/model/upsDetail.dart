class UpsDetail {
  String? nome;
  String? status;
  String? connection;
  String? ip;
  String? upsIdentManufacturer;
  String? upsIdentModel;
  String? upsIdentUPSSoftwareVersion;
  String? upsBatteryStatus;
  String? upsSecondsOnBattery;
  String? upsEstimatedChargeRemaining;
  String? upsEstimatedMinutesRemaining;
  String? upsBatteryVoltage;

  UpsDetail(
      {this.nome,
      this.status,
      this.connection,
      this.ip,
      this.upsIdentManufacturer,
      this.upsIdentModel,
      this.upsIdentUPSSoftwareVersion,
      this.upsBatteryStatus,
      this.upsSecondsOnBattery,
      this.upsEstimatedChargeRemaining,
      this.upsEstimatedMinutesRemaining,
      this.upsBatteryVoltage});

  UpsDetail.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    status = json['status'];
    connection = json['connection'];
    ip = json['ip'];
    upsIdentManufacturer = json['upsIdentManufacturer'];
    upsIdentModel = json['upsIdentModel'];
    upsIdentUPSSoftwareVersion = json['upsIdentUPSSoftwareVersion'];
    upsBatteryStatus = json['upsBatteryStatus'];
    upsSecondsOnBattery = json['upsSecondsOnBattery'];
    upsEstimatedChargeRemaining = json['upsEstimatedChargeRemaining'];
    upsEstimatedMinutesRemaining = json['upsEstimatedMinutesRemaining'];
    upsBatteryVoltage = json['upsBatteryVoltage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['status'] = this.status;
    data['connection'] = this.connection;
    data['ip'] = this.ip;
    data['upsIdentManufacturer'] = this.upsIdentManufacturer;
    data['upsIdentModel'] = this.upsIdentModel;
    data['upsIdentUPSSoftwareVersion'] = this.upsIdentUPSSoftwareVersion;
    data['upsBatteryStatus'] = this.upsBatteryStatus;
    data['upsSecondsOnBattery'] = this.upsSecondsOnBattery;
    data['upsEstimatedChargeRemaining'] = this.upsEstimatedChargeRemaining;
    data['upsEstimatedMinutesRemaining'] = this.upsEstimatedMinutesRemaining;
    data['upsBatteryVoltage'] = this.upsBatteryVoltage;
    return data;
  }
}
