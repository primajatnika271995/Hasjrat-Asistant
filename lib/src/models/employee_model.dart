// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  String id;
  String name;
  String type;
  String educationLevel;
  String eductionMajor;
  bool resign;
  String joinDate;
  String mutationDate;
  DateTime birthDate;
  bool bdeleted;
  String jenisKelamin;
  Branch branch;
  Branch outlet;
  Branch location;
  Branch job;
  Section section;
  String grading;

  EmployeeModel({
    this.id,
    this.name,
    this.type,
    this.educationLevel,
    this.eductionMajor,
    this.resign,
    this.joinDate,
    this.mutationDate,
    this.birthDate,
    this.bdeleted,
    this.jenisKelamin,
    this.branch,
    this.outlet,
    this.location,
    this.job,
    this.section,
    this.grading,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    educationLevel: json["educationLevel"] == null ? null : json["educationLevel"],
    eductionMajor: json["eductionMajor"] == null ? null : json["eductionMajor"],
    resign: json["resign"] == null ? null : json["resign"],
    joinDate: json["joinDate"] == null ? null : json["joinDate"],
    mutationDate: json["mutationDate"] == null ? null : json["mutationDate"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    bdeleted: json["bdeleted"] == null ? null : json["bdeleted"],
    jenisKelamin: json["jenisKelamin"] == null ? null : json["jenisKelamin"],
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    outlet: json["outlet"] == null ? null : Branch.fromJson(json["outlet"]),
    location: json["location"] == null ? null : Branch.fromJson(json["location"]),
    job: json["job"] == null ? null : Branch.fromJson(json["job"]),
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
    grading: json["grading"] == null ? null : json["grading"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "educationLevel": educationLevel == null ? null : educationLevel,
    "eductionMajor": eductionMajor == null ? null : eductionMajor,
    "resign": resign == null ? null : resign,
    "joinDate": joinDate == null ? null : joinDate,
    "mutationDate": mutationDate == null ? null : mutationDate,
    "birthDate": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "bdeleted": bdeleted == null ? null : bdeleted,
    "jenisKelamin": jenisKelamin == null ? null : jenisKelamin,
    "branch": branch == null ? null : branch.toJson(),
    "outlet": outlet == null ? null : outlet.toJson(),
    "location": location == null ? null : location.toJson(),
    "job": job == null ? null : job.toJson(),
    "section": section == null ? null : section.toJson(),
    "grading": grading == null ? null : grading,
  };
}

class Branch {
  String id;
  String name;

  Branch({
    this.id,
    this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
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
  String newName;

  Section({
    this.id,
    this.name,
    this.newName,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    newName: json["newName"] == null ? null : json["newName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "newName": newName == null ? null : newName,
  };
}
