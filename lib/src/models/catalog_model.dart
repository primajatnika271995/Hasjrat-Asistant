// To parse this JSON data, do
//
//     final catalogModel = catalogModelFromJson(jsonString);

import 'dart:convert';

List<CatalogModel> catalogModelFromJson(String str) => List<CatalogModel>.from(json.decode(str).map((x) => CatalogModel.fromJson(x)));

String catalogModelToJson(List<CatalogModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatalogModel {
    String id;
    String itemModel;
    String itemType;
    String itemClass;
    dynamic itemClass1;
    dynamic branchCode;
    dynamic outletCode;
    String createdBy;
    String createdDate;
    dynamic lastUpdateBy;
    dynamic lastUpdateDate;
    dynamic enabled;
    String titleReview;
    String descriptionReview;
    String category;
    dynamic archive;
    dynamic draft;

    CatalogModel({
        this.id,
        this.itemModel,
        this.itemType,
        this.itemClass,
        this.itemClass1,
        this.branchCode,
        this.outletCode,
        this.createdBy,
        this.createdDate,
        this.lastUpdateBy,
        this.lastUpdateDate,
        this.enabled,
        this.titleReview,
        this.descriptionReview,
        this.category,
        this.archive,
        this.draft,
    });

    factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        id: json["id"] == null ? null : json["id"],
        itemModel: json["itemModel"] == null ? null : json["itemModel"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        itemClass: json["itemClass"] == null ? null : json["itemClass"],
        itemClass1: json["itemClass1"],
        branchCode: json["branchCode"],
        outletCode: json["outletCode"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        lastUpdateBy: json["lastUpdateBy"],
        lastUpdateDate: json["lastUpdateDate"],
        enabled: json["enabled"],
        titleReview: json["titleReview"] == null ? null : json["titleReview"],
        descriptionReview: json["descriptionReview"] == null ? null : json["descriptionReview"],
        category: json["category"] == null ? null : json["category"],
        archive: json["archive"],
        draft: json["draft"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "itemModel": itemModel == null ? null : itemModel,
        "itemType": itemType == null ? null : itemType,
        "itemClass": itemClass == null ? null : itemClass,
        "itemClass1": itemClass1,
        "branchCode": branchCode,
        "outletCode": outletCode,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "lastUpdateBy": lastUpdateBy,
        "lastUpdateDate": lastUpdateDate,
        "enabled": enabled,
        "titleReview": titleReview == null ? null : titleReview,
        "descriptionReview": descriptionReview == null ? null : descriptionReview,
        "category": category == null ? null : category,
        "archive": archive,
        "draft": draft,
    };
}
