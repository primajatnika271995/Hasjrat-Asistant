// To parse this JSON data, do
//
//     final activityReportModel = activityReportModelFromJson(jsonString);

import 'dart:convert';

ActivityReportModel activityReportModelFromJson(String str) => ActivityReportModel.fromJson(json.decode(str));

String activityReportModelToJson(ActivityReportModel data) => json.encode(data.toJson());

class ActivityReportModel {
    ActivityReportModel({
        this.data,
        this.draw,
        this.recordsTotal,
        this.recordsFiltered,
    });

    List<Datum> data;
    int draw;
    int recordsTotal;
    int recordsFiltered;

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
    Datum({
        this.id,
        this.title,
        this.latitude,
        this.longitude,
        this.alamat,
        this.branchCode,
        this.outletCode,
        this.description,
        this.createdBy,
        this.createdDate,
        this.files,
        this.provinceCode,
        this.provinceName,
        this.kabupatenCode,
        this.kabupatenName,
        this.kecamatanCode,
        this.kecamatanName,
    });

    String id;
    String title;
    int latitude;
    int longitude;
    String alamat;
    String branchCode;
    String outletCode;
    String description;
    String createdBy;
    String createdDate;
    List<FileElement> files;
    String provinceCode;
    String provinceName;
    String kabupatenCode;
    String kabupatenName;
    String kecamatanCode;
    String kecamatanName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        description: json["description"] == null ? null : json["description"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        provinceCode: json["provinceCode"] == null ? null : json["provinceCode"],
        provinceName: json["provinceName"] == null ? null : json["provinceName"],
        kabupatenCode: json["kabupatenCode"] == null ? null : json["kabupatenCode"],
        kabupatenName: json["kabupatenName"] == null ? null : json["kabupatenName"],
        kecamatanCode: json["kecamatanCode"] == null ? null : json["kecamatanCode"],
        kecamatanName: json["kecamatanName"] == null ? null : json["kecamatanName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "alamat": alamat == null ? null : alamat,
        "branchCode": branchCode == null ? null : branchCode,
        "outletCode": outletCode == null ? null : outletCode,
        "description": description == null ? null : description,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
        "provinceCode": provinceCode == null ? null : provinceCode,
        "provinceName": provinceName == null ? null : provinceName,
        "kabupatenCode": kabupatenCode == null ? null : kabupatenCode,
        "kabupatenName": kabupatenName == null ? null : kabupatenName,
        "kecamatanCode": kecamatanCode == null ? null : kecamatanCode,
        "kecamatanName": kecamatanName == null ? null : kecamatanName,
    };
}

class FileElement {
    FileElement({
        this.id,
        this.filename,
        this.extension,
        this.url,
    });

    String id;
    String filename;
    String extension;
    String url;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"] == null ? null : json["id"],
        filename: json["filename"] == null ? null : json["filename"],
        extension: json["extension"] == null ? null : json["extension"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "filename": filename == null ? null : filename,
        "extension": extension == null ? null : extension,
        "url": url == null ? null : url,
    };
}
