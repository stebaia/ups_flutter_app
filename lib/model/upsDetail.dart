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
  String? statusInverter;
  String? sysInputRMSCurPhaseA;
  String? sysOutputRMSCurPhaseA;
  String? sysInputRMSANVolt;
  String? sysOutputRMSANVolt;
  String? airTemperatureCel;

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
      this.upsBatteryVoltage,
      this.statusInverter,
      this.sysInputRMSANVolt,
      this.sysInputRMSCurPhaseA,
      this.sysOutputRMSANVolt,
      this.sysOutputRMSCurPhaseA,
      this.airTemperatureCel});

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

    statusInverter = json['statusInverter'];
    sysInputRMSANVolt = json['SysInputRMS_AN_Volt'];
    sysOutputRMSANVolt = json['SysOutputRMS_AN_Volt'];
    sysInputRMSCurPhaseA = json['SysInputRMSCurPhaseA'];
    sysOutputRMSCurPhaseA = json['SysOutputRMSCurPhaseA'];
    airTemperatureCel = json['AirTemperatureCel'];
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
    data['statusInverter'] = this.statusInverter;
    data['SysInputRMS_AN_Volt'] = this.sysInputRMSANVolt;
    data['SysInputRMSCurPhaseA'] = this.sysInputRMSCurPhaseA;
    data['SysOutputRMS_AN_Volt'] = this.sysOutputRMSANVolt;
    data['SysOutputRMSCurPhaseA'] = this.sysOutputRMSCurPhaseA;
    data['AirTemperatureCel'] = this.airTemperatureCel;
    return data;
  }
}
