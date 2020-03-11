// To parse this JSON data, do
//
//     final assetPriceModel = assetPriceModelFromJson(jsonString);

import 'dart:convert';

AssetPriceModel assetPriceModelFromJson(String str) => AssetPriceModel.fromJson(json.decode(str));

String assetPriceModelToJson(AssetPriceModel data) => json.encode(data.toJson());

class AssetPriceModel {
  bool status;
  String message;
  List<Result> result;

  AssetPriceModel({
    this.status,
    this.message,
    this.result,
  });

  factory AssetPriceModel.fromJson(Map<String, dynamic> json) => AssetPriceModel(
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
  String priceListId;
  String priListTitle;
  String assetTypeCode;
  String assetTypeName;
  String price;
  dynamic dpBottomLimitPercentage;
  String dpBottomLimit;
  dynamic dpTopLimitPercentage;
  String dpTopLimit;
  String assetKind;
  dynamic assetKindName;
  String startDate;
  String endDate;
  String branchCode;
  String insuranceAssetType;
  String assetGroupCode;

  Result({
    this.priceListId,
    this.priListTitle,
    this.assetTypeCode,
    this.assetTypeName,
    this.price,
    this.dpBottomLimitPercentage,
    this.dpBottomLimit,
    this.dpTopLimitPercentage,
    this.dpTopLimit,
    this.assetKind,
    this.assetKindName,
    this.startDate,
    this.endDate,
    this.branchCode,
    this.insuranceAssetType,
    this.assetGroupCode,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    priceListId: json["priceListId"] == null ? null : json["priceListId"],
    priListTitle: json["priListTitle"] == null ? null : json["priListTitle"],
    assetTypeCode: json["assetTypeCode"] == null ? null : json["assetTypeCode"],
    assetTypeName: json["assetTypeName"] == null ? null : json["assetTypeName"],
    price: json["price"] == null ? null : json["price"],
    dpBottomLimitPercentage: json["dpBottomLimitPercentage"] == null ? null : json["dpBottomLimitPercentage"],
    dpBottomLimit: json["dpBottomLimit"] == null ? null : json["dpBottomLimit"],
    dpTopLimitPercentage: json["dpTopLimitPercentage"] == null ? null : json["dpTopLimitPercentage"],
    dpTopLimit: json["dpTopLimit"] == null ? null : json["dpTopLimit"],
    assetKind: json["assetKind"] == null ? null : json["assetKind"],
    assetKindName: json["assetKindName"],
    startDate: json["startDate"] == null ? null : json["startDate"],
    endDate: json["endDate"] == null ? null : json["endDate"],
    branchCode: json["branchCode"] == null ? null : json["branchCode"],
    insuranceAssetType: json["insuranceAssetType"] == null ? null : json["insuranceAssetType"],
    assetGroupCode: json["assetGroupCode"] == null ? null : json["assetGroupCode"],
  );

  Map<String, dynamic> toJson() => {
    "priceListId": priceListId == null ? null : priceListId,
    "priListTitle": priListTitle == null ? null : priListTitle,
    "assetTypeCode": assetTypeCode == null ? null : assetTypeCode,
    "assetTypeName": assetTypeName == null ? null : assetTypeName,
    "price": price == null ? null : price,
    "dpBottomLimitPercentage": dpBottomLimitPercentage == null ? null : dpBottomLimitPercentage,
    "dpBottomLimit": dpBottomLimit == null ? null : dpBottomLimit,
    "dpTopLimitPercentage": dpTopLimitPercentage == null ? null : dpTopLimitPercentage,
    "dpTopLimit": dpTopLimit == null ? null : dpTopLimit,
    "assetKind": assetKind == null ? null : assetKind,
    "assetKindName": assetKindName,
    "startDate": startDate == null ? null : startDate,
    "endDate": endDate == null ? null : endDate,
    "branchCode": branchCode == null ? null : branchCode,
    "insuranceAssetType": insuranceAssetType == null ? null : insuranceAssetType,
    "assetGroupCode": assetGroupCode == null ? null : assetGroupCode,
  };
}
