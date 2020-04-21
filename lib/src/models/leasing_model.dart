// To parse this JSON data, do
//
//     final leasingModel = leasingModelFromJson(jsonString);

import 'dart:convert';

LeasingModel leasingModelFromJson(String str) => LeasingModel.fromJson(json.decode(str));

String leasingModelToJson(LeasingModel data) => json.encode(data.toJson());

class LeasingModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  LeasingModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory LeasingModel.fromJson(Map<String, dynamic> json) => LeasingModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    retCode: json["retCode"] == null ? null : json["retCode"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "retCode": retCode == null ? null : retCode,
    "token": token,
  };
}

class Datum {
  int leasingId;
  String leasingCode;
  String leasingName;
  String leasingType;
  String leasingPerusahaan;
  String frozenFor;

  Datum({
    this.leasingId,
    this.leasingCode,
    this.leasingName,
    this.leasingType,
    this.leasingPerusahaan,
    this.frozenFor,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    leasingId: json["leasing_id"] == null ? null : json["leasing_id"],
    leasingCode: json["leasing_code"] == null ? null : json["leasing_code"],
    leasingName: json["leasing_name"] == null ? null : json["leasing_name"],
    leasingType: json["leasing_type"] == null ? null : json["leasing_type"],
    leasingPerusahaan: json["leasing_perusahaan"] == null ? null : json["leasing_perusahaan"],
    frozenFor: json["frozen_for"] == null ? null : json["frozen_for"],
  );

  Map<String, dynamic> toJson() => {
    "leasing_id": leasingId == null ? null : leasingId,
    "leasing_code": leasingCode == null ? null : leasingCode,
    "leasing_name": leasingName == null ? null : leasingName,
    "leasing_type": leasingType == null ? null : leasingType,
    "leasing_perusahaan": leasingPerusahaan == null ? null : leasingPerusahaan,
    "frozen_for": frozenFor == null ? null : frozenFor,
  };
}
