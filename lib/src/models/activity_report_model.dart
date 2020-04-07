// To parse this JSON data, do
//
//     final activityReportModel = activityReportModelFromJson(jsonString);

import 'dart:convert';

ActivityReportModel activityReportModelFromJson(String str) => ActivityReportModel.fromJson(json.decode(str));

String activityReportModelToJson(ActivityReportModel data) => json.encode(data.toJson());

class ActivityReportModel {
  List<Datum> data;
  int draw;
  int recordsTotal;
  int recordsFiltered;

  ActivityReportModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory ActivityReportModel.fromJson(Map<String, dynamic> json) => ActivityReportModel(
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
  String title;
  int latitude;
  int longitude;
  String alamat;
  String description;
  String createdBy;
  String createdDate;
  List<dynamic> files;

  Datum({
    this.id,
    this.title,
    this.latitude,
    this.longitude,
    this.alamat,
    this.description,
    this.createdBy,
    this.createdDate,
    this.files,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    description: json["description"] == null ? null : json["description"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    files: json["files"] == null ? null : List<dynamic>.from(json["files"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "alamat": alamat == null ? null : alamat,
    "description": description == null ? null : description,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate,
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x)),
  };
}
