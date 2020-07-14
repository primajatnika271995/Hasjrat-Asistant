// To parse this JSON data, do
//
//     final checkStockModel = checkStockModelFromJson(jsonString);

import 'dart:convert';

CheckStockModel checkStockModelFromJson(String str) => CheckStockModel.fromJson(json.decode(str));

String checkStockModelToJson(CheckStockModel data) => json.encode(data.toJson());

class CheckStockModel {
    CheckStockModel({
        this.data,
        this.draw,
        this.recordsTotal,
        this.recordsFiltered,
    });

    List<Datum> data;
    int draw;
    int recordsTotal;
    int recordsFiltered;

    factory CheckStockModel.fromJson(Map<String, dynamic> json) => CheckStockModel(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        draw: json["draw"] == null ? null : json["draw"],
        recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "draw": draw == null ? null : draw,
        "recordsTotal": recordsTotal == null ? null : recordsTotal,
        "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
    };
}

class Datum {
    Datum({
        this.branchCode,
        this.branchName,
        this.class1,
        this.model,
        this.itemType,
        this.itemCode,
        this.itemName,
        this.tahunProduksi,
        this.kodeWarna,
        this.namaWarna,
        this.whsCode,
        this.whsName,
        this.quantity,
        this.value,
    });

    String branchCode;
    String branchName;
    String class1;
    String model;
    String itemType;
    String itemCode;
    String itemName;
    int tahunProduksi;
    String kodeWarna;
    String namaWarna;
    String whsCode;
    String whsName;
    int quantity;
    double value;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        branchName: json["branchName"] == null ? null : json["branchName"],
        class1: json["class1"] == null ? null : json["class1"],
        model: json["model"] == null ? null : json["model"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        itemCode: json["itemCode"] == null ? null : json["itemCode"],
        itemName: json["itemName"] == null ? null : json["itemName"],
        tahunProduksi: json["tahunProduksi"] == null ? null : json["tahunProduksi"],
        kodeWarna: json["kodeWarna"] == null ? null : json["kodeWarna"],
        namaWarna: json["namaWarna"] == null ? null : json["namaWarna"],
        whsCode: json["whsCode"] == null ? null : json["whsCode"],
        whsName: json["whsName"] == null ? null : json["whsName"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        value: json["value"] == null ? null : json["value"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "branchCode": branchCode == null ? null : branchCode,
        "branchName": branchName == null ? null : branchName,
        "class1": class1 == null ? null : class1,
        "model": model == null ? null : model,
        "itemType": itemType == null ? null : itemType,
        "itemCode": itemCode == null ? null : itemCode,
        "itemName": itemName == null ? null : itemName,
        "tahunProduksi": tahunProduksi == null ? null : tahunProduksi,
        "kodeWarna": kodeWarna == null ? null : kodeWarna,
        "namaWarna": namaWarna == null ? null : namaWarna,
        "whsCode": whsCode == null ? null : whsCode,
        "whsName": whsName == null ? null : whsName,
        "quantity": quantity == null ? null : quantity,
        "value": value == null ? null : value,
    };
}
