// To parse this JSON data, do
//
//     final assetTypeModel = assetTypeModelFromJson(jsonString);

import 'dart:convert';

AssetTypeModel assetTypeModelFromJson(String str) => AssetTypeModel.fromJson(json.decode(str));

String assetTypeModelToJson(AssetTypeModel data) => json.encode(data.toJson());

class AssetTypeModel {
  bool status;
  String message;
  List<Result> result;

  AssetTypeModel({
    this.status,
    this.message,
    this.result,
  });

  factory AssetTypeModel.fromJson(Map<String, dynamic> json) => AssetTypeModel(
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
  String assetTypeCode;
  String assetTypeName;

  Result({
    this.assetTypeCode,
    this.assetTypeName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    assetTypeCode: json["assetTypeCode"] == null ? null : json["assetTypeCode"],
    assetTypeName: json["assetTypeName"] == null ? null : json["assetTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "assetTypeCode": assetTypeCode == null ? null : assetTypeCode,
    "assetTypeName": assetTypeName == null ? null : assetTypeName,
  };
}
