// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  DistrictModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
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
  int kabupatenId;
  String provinsiCode;
  String kabupatenCode;
  String kabupatenName;

  Datum({
    this.kabupatenId,
    this.provinsiCode,
    this.kabupatenCode,
    this.kabupatenName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    kabupatenId: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    provinsiCode: json["provinsi_code"] == null ? null : json["provinsi_code"],
    kabupatenCode: json["kabupaten_code"] == null ? null : json["kabupaten_code"],
    kabupatenName: json["kabupaten_name"] == null ? null : json["kabupaten_name"],
  );

  Map<String, dynamic> toJson() => {
    "kabupaten_id": kabupatenId == null ? null : kabupatenId,
    "provinsi_code": provinsiCode == null ? null : provinsiCode,
    "kabupaten_code": kabupatenCode == null ? null : kabupatenCode,
    "kabupaten_name": kabupatenName == null ? null : kabupatenName,
  };
}
