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
    dynamic itemClass;
    String itemClass1;
    String branchCode;
    String outletCode;
    String titleReview;
    String descriptionReview;
    String category;
    String createdBy;
    String createdDate;
    String lastUpdateBy;
    String lastUpdateDate;
    bool enabled;
    bool archive;
    bool draft;
    List<Colour> colours;
    List<dynamic> galleriesInterior;
    List<dynamic> galleriesExterior;
    List<dynamic> accessories;
    List<dynamic> features;

    CatalogModel({
        this.id,
        this.itemModel,
        this.itemType,
        this.itemClass,
        this.itemClass1,
        this.branchCode,
        this.outletCode,
        this.titleReview,
        this.descriptionReview,
        this.category,
        this.createdBy,
        this.createdDate,
        this.lastUpdateBy,
        this.lastUpdateDate,
        this.enabled,
        this.archive,
        this.draft,
        this.colours,
        this.galleriesInterior,
        this.galleriesExterior,
        this.accessories,
        this.features,
    });

    factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        id: json["id"] == null ? null : json["id"],
        itemModel: json["itemModel"] == null ? null : json["itemModel"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        itemClass: json["itemClass"],
        itemClass1: json["itemClass1"] == null ? null : json["itemClass1"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        titleReview: json["titleReview"] == null ? null : json["titleReview"],
        descriptionReview: json["descriptionReview"] == null ? null : json["descriptionReview"],
        category: json["category"] == null ? null : json["category"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        lastUpdateBy: json["lastUpdateBy"] == null ? null : json["lastUpdateBy"],
        lastUpdateDate: json["lastUpdateDate"] == null ? null : json["lastUpdateDate"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        archive: json["archive"] == null ? null : json["archive"],
        draft: json["draft"] == null ? null : json["draft"],
        colours: json["colours"] == null ? null : List<Colour>.from(json["colours"].map((x) => Colour.fromJson(x))),
        galleriesInterior: json["galleriesInterior"] == null ? null : List<dynamic>.from(json["galleriesInterior"].map((x) => x)),
        galleriesExterior: json["galleriesExterior"] == null ? null : List<dynamic>.from(json["galleriesExterior"].map((x) => x)),
        accessories: json["accessories"] == null ? null : List<dynamic>.from(json["accessories"].map((x) => x)),
        features: json["features"] == null ? null : List<dynamic>.from(json["features"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "itemModel": itemModel == null ? null : itemModel,
        "itemType": itemType == null ? null : itemType,
        "itemClass": itemClass,
        "itemClass1": itemClass1 == null ? null : itemClass1,
        "branchCode": branchCode == null ? null : branchCode,
        "outletCode": outletCode == null ? null : outletCode,
        "titleReview": titleReview == null ? null : titleReview,
        "descriptionReview": descriptionReview == null ? null : descriptionReview,
        "category": category == null ? null : category,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "lastUpdateBy": lastUpdateBy == null ? null : lastUpdateBy,
        "lastUpdateDate": lastUpdateDate == null ? null : lastUpdateDate,
        "enabled": enabled == null ? null : enabled,
        "archive": archive == null ? null : archive,
        "draft": draft == null ? null : draft,
        "colours": colours == null ? null : List<dynamic>.from(colours.map((x) => x.toJson())),
        "galleriesInterior": galleriesInterior == null ? null : List<dynamic>.from(galleriesInterior.map((x) => x)),
        "galleriesExterior": galleriesExterior == null ? null : List<dynamic>.from(galleriesExterior.map((x) => x)),
        "accessories": accessories == null ? null : List<dynamic>.from(accessories.map((x) => x)),
        "features": features == null ? null : List<dynamic>.from(features.map((x) => x)),
    };
}

class Colour {
    String id;
    String colorCode;
    String colorNameEn;
    String colorNameIn;
    String image;

    Colour({
        this.id,
        this.colorCode,
        this.colorNameEn,
        this.colorNameIn,
        this.image,
    });

    factory Colour.fromJson(Map<String, dynamic> json) => Colour(
        id: json["id"] == null ? null : json["id"],
        colorCode: json["colorCode"] == null ? null : json["colorCode"],
        colorNameEn: json["colorNameEn"] == null ? null : json["colorNameEn"],
        colorNameIn: json["colorNameIn"] == null ? null : json["colorNameIn"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "colorCode": colorCode == null ? null : colorCode,
        "colorNameEn": colorNameEn == null ? null : colorNameEn,
        "colorNameIn": colorNameIn == null ? null : colorNameIn,
        "image": image == null ? null : image,
    };
}
