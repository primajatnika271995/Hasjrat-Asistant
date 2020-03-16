// To parse this JSON data, do
//
//     final subDistrictModel = subDistrictModelFromJson(jsonString);

import 'dart:convert';

SubDistrictModel subDistrictModelFromJson(String str) => SubDistrictModel.fromJson(json.decode(str));

String subDistrictModelToJson(SubDistrictModel data) => json.encode(data.toJson());

class SubDistrictModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  SubDistrictModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory SubDistrictModel.fromJson(Map<String, dynamic> json) => SubDistrictModel(
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
  int kecamatanId;
  String provinsiCode;
  String kabupatenCode;
  String kecamatanCode;
  String kecamatanName;

  Datum({
    this.kecamatanId,
    this.provinsiCode,
    this.kabupatenCode,
    this.kecamatanCode,
    this.kecamatanName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    kecamatanId: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
    provinsiCode: json["provinsi_code"] == null ? null : json["provinsi_code"],
    kabupatenCode: json["kabupaten_code"] == null ? null : json["kabupaten_code"],
    kecamatanCode: json["kecamatan_code"] == null ? null : json["kecamatan_code"],
    kecamatanName: json["kecamatan_name"] == null ? null : json["kecamatan_name"],
  );

  Map<String, dynamic> toJson() => {
    "kecamatan_id": kecamatanId == null ? null : kecamatanId,
    "provinsi_code": provinsiCode == null ? null : provinsiCode,
    "kabupaten_code": kabupatenCode == null ? null : kabupatenCode,
    "kecamatan_code": kecamatanCode == null ? null : kecamatanCode,
    "kecamatan_name": kecamatanName == null ? null : kecamatanName,
  };
}
