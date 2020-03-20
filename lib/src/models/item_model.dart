// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  ItemModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
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
  String itemModel;
  String itemType;
  String itemClass;
  dynamic itemClass1;
  List<Colour> colours;

  Datum({
    this.itemModel,
    this.itemType,
    this.itemClass,
    this.itemClass1,
    this.colours,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    itemClass: json["item_class"] == null ? null : json["item_class"],
    itemClass1: json["item_class1"],
    colours: json["colours"] == null ? null : List<Colour>.from(json["colours"].map((x) => Colour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "item_model": itemModel == null ? null : itemModel,
    "item_type": itemType == null ? null : itemType,
    "item_class": itemClass == null ? null : itemClass,
    "item_class1": itemClass1,
    "colours": colours == null ? null : List<dynamic>.from(colours.map((x) => x.toJson())),
  };
}

class Colour {
  String itemModel;
  String itemType;
  String kodeWarna;
  String namaWarnaEng;
  String namaWarnaInd;

  Colour({
    this.itemModel,
    this.itemType,
    this.kodeWarna,
    this.namaWarnaEng,
    this.namaWarnaInd,
  });

  factory Colour.fromJson(Map<String, dynamic> json) => Colour(
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    kodeWarna: json["kode_warna"] == null ? null : json["kode_warna"],
    namaWarnaEng: json["nama_warna_eng"] == null ? null : json["nama_warna_eng"],
    namaWarnaInd: json["nama_warna_ind"] == null ? null : json["nama_warna_ind"],
  );

  Map<String, dynamic> toJson() => {
    "item_model": itemModel == null ? null : itemModel,
    "item_type": itemType == null ? null : itemType,
    "kode_warna": kodeWarna == null ? null : kodeWarna,
    "nama_warna_eng": namaWarnaEng == null ? null : namaWarnaEng,
    "nama_warna_ind": namaWarnaInd == null ? null : namaWarnaInd,
  };
}
