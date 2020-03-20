// To parse this JSON data, do
//
//     final priceListModel = priceListModelFromJson(jsonString);

import 'dart:convert';

PriceListModel priceListModelFromJson(String str) => PriceListModel.fromJson(json.decode(str));

String priceListModelToJson(PriceListModel data) => json.encode(data.toJson());

class PriceListModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  PriceListModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory PriceListModel.fromJson(Map<String, dynamic> json) => PriceListModel(
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
  int pricelistId;
  String pricelistCode;
  int customerGroupId;
  String itemModel;
  String itemType;
  String itemCode;
  int itemGroup;
  int offtr;
  int bbn;
  int logistic;
  int ontr;
  DateTime pricelistTanggal;
  String dalamKota;
  String customerGroupName;

  Datum({
    this.pricelistId,
    this.pricelistCode,
    this.customerGroupId,
    this.itemModel,
    this.itemType,
    this.itemCode,
    this.itemGroup,
    this.offtr,
    this.bbn,
    this.logistic,
    this.ontr,
    this.pricelistTanggal,
    this.dalamKota,
    this.customerGroupName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    pricelistId: json["pricelist_id"] == null ? null : json["pricelist_id"],
    pricelistCode: json["pricelist_code"] == null ? null : json["pricelist_code"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    itemCode: json["item_code"] == null ? null : json["item_code"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    offtr: json["offtr"] == null ? null : json["offtr"],
    bbn: json["bbn"] == null ? null : json["bbn"],
    logistic: json["logistic"] == null ? null : json["logistic"],
    ontr: json["ontr"] == null ? null : json["ontr"],
    pricelistTanggal: json["pricelist_tanggal"] == null ? null : DateTime.parse(json["pricelist_tanggal"]),
    dalamKota: json["dalam_kota"] == null ? null : json["dalam_kota"],
    customerGroupName: json["customer_group_name"] == null ? null : json["customer_group_name"],
  );

  Map<String, dynamic> toJson() => {
    "pricelist_id": pricelistId == null ? null : pricelistId,
    "pricelist_code": pricelistCode == null ? null : pricelistCode,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "item_model": itemModel == null ? null : itemModel,
    "item_type": itemType == null ? null : itemType,
    "item_code": itemCode == null ? null : itemCode,
    "item_group": itemGroup == null ? null : itemGroup,
    "offtr": offtr == null ? null : offtr,
    "bbn": bbn == null ? null : bbn,
    "logistic": logistic == null ? null : logistic,
    "ontr": ontr == null ? null : ontr,
    "pricelist_tanggal": pricelistTanggal == null ? null : pricelistTanggal.toIso8601String(),
    "dalam_kota": dalamKota == null ? null : dalamKota,
    "customer_group_name": customerGroupName == null ? null : customerGroupName,
  };
}
