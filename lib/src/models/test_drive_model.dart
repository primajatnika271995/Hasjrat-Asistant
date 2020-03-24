// To parse this JSON data, do
//
//     final testDriveModel = testDriveModelFromJson(jsonString);

import 'dart:convert';

List<TestDriveModel> testDriveModelFromJson(String str) => List<TestDriveModel>.from(json.decode(str).map((x) => TestDriveModel.fromJson(x)));

String testDriveModelToJson(List<TestDriveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestDriveModel {
    String id;
    String itemModel;
    String itemType;
    String itemClass;
    dynamic itemClass1;
    String colorId;
    String colorNameEn;
    String colorNameId;
    String noPolisi;
    String branchCode;
    String outletCode;
    String createdBy;
    String createdDate;
    bool enabled;

    TestDriveModel({
        this.id,
        this.itemModel,
        this.itemType,
        this.itemClass,
        this.itemClass1,
        this.colorId,
        this.colorNameEn,
        this.colorNameId,
        this.noPolisi,
        this.branchCode,
        this.outletCode,
        this.createdBy,
        this.createdDate,
        this.enabled,
    });

    factory TestDriveModel.fromJson(Map<String, dynamic> json) => TestDriveModel(
        id: json["id"] == null ? null : json["id"],
        itemModel: json["itemModel"] == null ? null : json["itemModel"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        itemClass: json["itemClass"] == null ? null : json["itemClass"],
        itemClass1: json["itemClass1"],
        colorId: json["colorId"] == null ? null : json["colorId"],
        colorNameEn: json["colorNameEN"] == null ? null : json["colorNameEN"],
        colorNameId: json["colorNameID"] == null ? null : json["colorNameID"],
        noPolisi: json["noPolisi"] == null ? null : json["noPolisi"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        enabled: json["enabled"] == null ? null : json["enabled"],
    );

  get data => null;

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "itemModel": itemModel == null ? null : itemModel,
        "itemType": itemType == null ? null : itemType,
        "itemClass": itemClass == null ? null : itemClass,
        "itemClass1": itemClass1,
        "colorId": colorId == null ? null : colorId,
        "colorNameEN": colorNameEn == null ? null : colorNameEn,
        "colorNameID": colorNameId == null ? null : colorNameId,
        "noPolisi": noPolisi == null ? null : noPolisi,
        "branchCode": branchCode == null ? null : branchCode,
        "outletCode": outletCode == null ? null : outletCode,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "enabled": enabled == null ? null : enabled,
    };
}
