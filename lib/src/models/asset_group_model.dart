// To parse this JSON data, do
//
//     final assetGroupModel = assetGroupModelFromJson(jsonString);

import 'dart:convert';

AssetGroupModel assetGroupModelFromJson(String str) => AssetGroupModel.fromJson(json.decode(str));

String assetGroupModelToJson(AssetGroupModel data) => json.encode(data.toJson());

class AssetGroupModel {
  bool status;
  String message;
  List<Result> result;

  AssetGroupModel({
    this.status,
    this.message,
    this.result,
  });

  factory AssetGroupModel.fromJson(Map<String, dynamic> json) => AssetGroupModel(
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
  String assetGroupCode;
  String assetGroupName;
  String assetKindCode;
  String assetKindName;

  Result({
    this.assetGroupCode,
    this.assetGroupName,
    this.assetKindCode,
    this.assetKindName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    assetGroupCode: json["assetGroupCode"] == null ? null : json["assetGroupCode"],
    assetGroupName: json["assetGroupName"] == null ? null : json["assetGroupName"],
    assetKindCode: json["assetKindCode"] == null ? null : json["assetKindCode"],
    assetKindName: json["assetKindName"] == null ? null : json["assetKindName"],
  );

  Map<String, dynamic> toJson() => {
    "assetGroupCode": assetGroupCode == null ? null : assetGroupCode,
    "assetGroupName": assetGroupName == null ? null : assetGroupName,
    "assetKindCode": assetKindCode == null ? null : assetKindCode,
    "assetKindName": assetKindName == null ? null : assetKindName,
  };
}
