// To parse this JSON data, do
//
//     final insuranceModel = insuranceModelFromJson(jsonString);

import 'dart:convert';

InsuranceModel insuranceModelFromJson(String str) => InsuranceModel.fromJson(json.decode(str));

String insuranceModelToJson(InsuranceModel data) => json.encode(data.toJson());

class InsuranceModel {
  bool status;
  String message;
  List<Result> result;

  InsuranceModel({
    this.status,
    this.message,
    this.result,
  });

  factory InsuranceModel.fromJson(Map<String, dynamic> json) => InsuranceModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "result": result == null ? null : List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String assetKindCode;
  String assetKindName;
  String insuranceTypeCode;
  String insuranceTypeName;

  Result({
    this.assetKindCode,
    this.assetKindName,
    this.insuranceTypeCode,
    this.insuranceTypeName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    assetKindCode: json["assetKindCode"] == null ? null : json["assetKindCode"],
    assetKindName: json["assetKindName"] == null ? null : json["assetKindName"],
    insuranceTypeCode: json["insuranceTypeCode"] == null ? null : json["insuranceTypeCode"],
    insuranceTypeName: json["insuranceTypeName"] == null ? null : json["insuranceTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "assetKindCode": assetKindCode == null ? null : assetKindCode,
    "assetKindName": assetKindName == null ? null : assetKindName,
    "insuranceTypeCode": insuranceTypeCode == null ? null : insuranceTypeCode,
    "insuranceTypeName": insuranceTypeName == null ? null : insuranceTypeName,
  };
}
