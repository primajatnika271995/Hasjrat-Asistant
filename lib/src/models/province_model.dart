// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  ProvinceModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
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
  int provinsiId;
  String provinsiCode;
  String provinsiName;
  String regionCode;

  Datum({
    this.provinsiId,
    this.provinsiCode,
    this.provinsiName,
    this.regionCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    provinsiId: json["provinsi_id"] == null ? null : json["provinsi_id"],
    provinsiCode: json["provinsi_code"] == null ? null : json["provinsi_code"],
    provinsiName: json["provinsi_name"] == null ? null : json["provinsi_name"],
    regionCode: json["region_code"] == null ? null : json["region_code"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi_id": provinsiId == null ? null : provinsiId,
    "provinsi_code": provinsiCode == null ? null : provinsiCode,
    "provinsi_name": provinsiName == null ? null : provinsiName,
    "region_code": regionCode == null ? null : regionCode,
  };
}
