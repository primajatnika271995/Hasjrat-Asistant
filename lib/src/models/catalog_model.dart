// To parse this JSON data, do
//
//     final catalogModel = catalogModelFromJson(jsonString);

import 'dart:convert';

CatalogModel catalogModelFromJson(String str) => CatalogModel.fromJson(json.decode(str));

String catalogModelToJson(CatalogModel data) => json.encode(data.toJson());

class CatalogModel {
    List<Datum> data;
    int draw;
    int recordsTotal;
    int recordsFiltered;

    CatalogModel({
        this.data,
        this.draw,
        this.recordsTotal,
        this.recordsFiltered,
    });

    factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
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
    String id;
    String itemModel;
    String itemType;
    dynamic itemClass;
    String itemClass1;
    String branchCode;
    String outletCode;
    dynamic titleReview;
    dynamic descriptionReview;
    dynamic category;
    String createdBy;
    String createdDate;
    dynamic lastUpdateBy;
    dynamic lastUpdateDate;
    bool enabled;
    List<Colour> colours;
    List<Feature> galleriesInterior;
    List<Feature> galleriesExterior;
    List<dynamic> accessories;
    List<Feature> features;

    Datum({
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
        this.colours,
        this.galleriesInterior,
        this.galleriesExterior,
        this.accessories,
        this.features,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        itemModel: json["itemModel"] == null ? null : json["itemModel"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        itemClass: json["itemClass"],
        itemClass1: json["itemClass1"] == null ? null : json["itemClass1"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        titleReview: json["titleReview"],
        descriptionReview: json["descriptionReview"],
        category: json["category"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        lastUpdateBy: json["lastUpdateBy"],
        lastUpdateDate: json["lastUpdateDate"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        colours: json["colours"] == null ? null : List<Colour>.from(json["colours"].map((x) => Colour.fromJson(x))),
        galleriesInterior: json["galleriesInterior"] == null ? null : List<Feature>.from(json["galleriesInterior"].map((x) => Feature.fromJson(x))),
        galleriesExterior: json["galleriesExterior"] == null ? null : List<Feature>.from(json["galleriesExterior"].map((x) => Feature.fromJson(x))),
        accessories: json["accessories"] == null ? null : List<dynamic>.from(json["accessories"].map((x) => x)),
        features: json["features"] == null ? null : List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "itemModel": itemModel == null ? null : itemModel,
        "itemType": itemType == null ? null : itemType,
        "itemClass": itemClass,
        "itemClass1": itemClass1 == null ? null : itemClass1,
        "branchCode": branchCode == null ? null : branchCode,
        "outletCode": outletCode == null ? null : outletCode,
        "titleReview": titleReview,
        "descriptionReview": descriptionReview,
        "category": category,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "lastUpdateBy": lastUpdateBy,
        "lastUpdateDate": lastUpdateDate,
        "enabled": enabled == null ? null : enabled,
        "colours": colours == null ? null : List<dynamic>.from(colours.map((x) => x.toJson())),
        "galleriesInterior": galleriesInterior == null ? null : List<dynamic>.from(galleriesInterior.map((x) => x.toJson())),
        "galleriesExterior": galleriesExterior == null ? null : List<dynamic>.from(galleriesExterior.map((x) => x.toJson())),
        "accessories": accessories == null ? null : List<dynamic>.from(accessories.map((x) => x)),
        "features": features == null ? null : List<dynamic>.from(features.map((x) => x.toJson())),
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

class Feature {
    String id;
    String image;
    String title;
    String description;

    Feature({
        this.id,
        this.image,
        this.title,
        this.description,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
    };
}
