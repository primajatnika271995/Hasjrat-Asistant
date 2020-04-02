// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  List<Datum> data;
  int draw;
  int recordsTotal;
  int recordsFiltered;

  BannerModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
  String extension;
  String url;
  String notes;
  String title;
  String started;
  String expiredIn;
  dynamic publish;
  dynamic publishAt;
  dynamic publishBy;
  dynamic draft;
  dynamic archive;
  String createdBy;
  String createdDate;
  dynamic lastUpdatedBy;
  dynamic lastUpdatedDate;

  Datum({
    this.id,
    this.extension,
    this.url,
    this.notes,
    this.title,
    this.started,
    this.expiredIn,
    this.publish,
    this.publishAt,
    this.publishBy,
    this.draft,
    this.archive,
    this.createdBy,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    extension: json["extension"] == null ? null : json["extension"],
    url: json["url"] == null ? null : json["url"],
    notes: json["notes"] == null ? null : json["notes"],
    title: json["title"] == null ? null : json["title"],
    started: json["started"] == null ? null : json["started"],
    expiredIn: json["expiredIn"] == null ? null : json["expiredIn"],
    publish: json["publish"],
    publishAt: json["publishAt"],
    publishBy: json["publishBy"],
    draft: json["draft"],
    archive: json["archive"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    lastUpdatedBy: json["lastUpdatedBy"],
    lastUpdatedDate: json["lastUpdatedDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "extension": extension == null ? null : extension,
    "url": url == null ? null : url,
    "notes": notes == null ? null : notes,
    "title": title == null ? null : title,
    "started": started == null ? null : started,
    "expiredIn": expiredIn == null ? null : expiredIn,
    "publish": publish,
    "publishAt": publishAt,
    "publishBy": publishBy,
    "draft": draft,
    "archive": archive,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate,
    "lastUpdatedBy": lastUpdatedBy,
    "lastUpdatedDate": lastUpdatedDate,
  };
}
