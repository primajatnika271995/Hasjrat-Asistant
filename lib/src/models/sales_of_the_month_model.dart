// To parse this JSON data, do
//
//     final salesOfTheMonthModel = salesOfTheMonthModelFromJson(jsonString);

import 'dart:convert';

SalesOfTheMonthModel salesOfTheMonthModelFromJson(String str) => SalesOfTheMonthModel.fromJson(json.decode(str));

String salesOfTheMonthModelToJson(SalesOfTheMonthModel data) => json.encode(data.toJson());

class SalesOfTheMonthModel {
  String id;
  String name;
  String type;
  String educationLevel;
  String eductionMajor;
  String joinDate;
  dynamic birthDate;
  dynamic jenisKelamin;
  Job location;
  Job job;
  Section section;
  String branchCode;
  String outletCode;
  DateTime yearMonth;
  String imageUrl;
  String createdBy;
  String createdDate;

  SalesOfTheMonthModel({
    this.id,
    this.name,
    this.type,
    this.educationLevel,
    this.eductionMajor,
    this.joinDate,
    this.birthDate,
    this.jenisKelamin,
    this.location,
    this.job,
    this.section,
    this.branchCode,
    this.outletCode,
    this.yearMonth,
    this.imageUrl,
    this.createdBy,
    this.createdDate,
  });

  factory SalesOfTheMonthModel.fromJson(Map<String, dynamic> json) => SalesOfTheMonthModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    educationLevel: json["educationLevel"] == null ? null : json["educationLevel"],
    eductionMajor: json["eductionMajor"] == null ? null : json["eductionMajor"],
    joinDate: json["joinDate"] == null ? null : json["joinDate"],
    birthDate: json["birthDate"],
    jenisKelamin: json["jenisKelamin"],
    location: json["location"] == null ? null : Job.fromJson(json["location"]),
    job: json["job"] == null ? null : Job.fromJson(json["job"]),
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
    branchCode: json["branchCode"] == null ? null : json["branchCode"],
    outletCode: json["outletCode"] == null ? null : json["outletCode"],
    yearMonth: json["yearMonth"] == null ? null : DateTime.parse(json["yearMonth"]),
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "educationLevel": educationLevel == null ? null : educationLevel,
    "eductionMajor": eductionMajor == null ? null : eductionMajor,
    "joinDate": joinDate == null ? null : joinDate,
    "birthDate": birthDate,
    "jenisKelamin": jenisKelamin,
    "location": location == null ? null : location.toJson(),
    "job": job == null ? null : job.toJson(),
    "section": section == null ? null : section.toJson(),
    "branchCode": branchCode == null ? null : branchCode,
    "outletCode": outletCode == null ? null : outletCode,
    "yearMonth": yearMonth == null ? null : "${yearMonth.year.toString().padLeft(4, '0')}-${yearMonth.month.toString().padLeft(2, '0')}-${yearMonth.day.toString().padLeft(2, '0')}",
    "imageUrl": imageUrl == null ? null : imageUrl,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate,
  };
}

class Job {
  String id;
  String name;

  Job({
    this.id,
    this.name,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Section {
  String id;
  String name;
  dynamic newName;

  Section({
    this.id,
    this.name,
    this.newName,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    newName: json["newName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "newName": newName,
  };
}
