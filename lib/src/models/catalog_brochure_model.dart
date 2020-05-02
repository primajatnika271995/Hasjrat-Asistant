// To parse this JSON data, do
//
//     final brochureModel = brochureModelFromJson(jsonString);

import 'dart:convert';

BrochureModel brochureModelFromJson(String str) => BrochureModel.fromJson(json.decode(str));

String brochureModelToJson(BrochureModel data) => json.encode(data.toJson());

class BrochureModel {
    List<Datum> data;
    int draw;
    int recordsTotal;
    int recordsFiltered;

    BrochureModel({
        this.data,
        this.draw,
        this.recordsTotal,
        this.recordsFiltered,
    });

    factory BrochureModel.fromJson(Map<String, dynamic> json) => BrochureModel(
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
    String url;
    String description;
    String title;
    String createdBy;
    String createdDate;
    String lastUpdatedBy;
    dynamic lastUpdateDate;

    Datum({
        this.id,
        this.url,
        this.description,
        this.title,
        this.createdBy,
        this.createdDate,
        this.lastUpdatedBy,
        this.lastUpdateDate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        description: json["description"] == null ? null : json["description"],
        title: json["title"] == null ? null : json["title"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        lastUpdatedBy: json["lastUpdatedBy"] == null ? null : json["lastUpdatedBy"],
        lastUpdateDate: json["lastUpdateDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "description": description == null ? null : description,
        "title": title == null ? null : title,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "lastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
        "lastUpdateDate": lastUpdateDate,
    };
}
