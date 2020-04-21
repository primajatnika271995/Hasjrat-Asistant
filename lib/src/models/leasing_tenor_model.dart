// To parse this JSON data, do
//
//     final leasingTenorModel = leasingTenorModelFromJson(jsonString);

import 'dart:convert';

LeasingTenorModel leasingTenorModelFromJson(String str) => LeasingTenorModel.fromJson(json.decode(str));

String leasingTenorModelToJson(LeasingTenorModel data) => json.encode(data.toJson());

class LeasingTenorModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  LeasingTenorModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory LeasingTenorModel.fromJson(Map<String, dynamic> json) => LeasingTenorModel(
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
  int tenorCreditId;
  int tenorNum;
  String tenorDesc;

  Datum({
    this.tenorCreditId,
    this.tenorNum,
    this.tenorDesc,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    tenorCreditId: json["tenor_credit_id"] == null ? null : json["tenor_credit_id"],
    tenorNum: json["tenor_num"] == null ? null : json["tenor_num"],
    tenorDesc: json["tenor_desc"] == null ? null : json["tenor_desc"],
  );

  Map<String, dynamic> toJson() => {
    "tenor_credit_id": tenorCreditId == null ? null : tenorCreditId,
    "tenor_num": tenorNum == null ? null : tenorNum,
    "tenor_desc": tenorDesc == null ? null : tenorDesc,
  };
}
