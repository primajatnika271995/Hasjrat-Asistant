// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  String id;
  String username;
  String email;
  bool active;
  String jenisKelamin;
  String type;
  String educationLevel;
  String eductionMajor;
  String joinDate;
  DateTime birthDate;
  Branch branch;
  Branch outlet;
  Branch location;
  Branch job;
  Section section;
  String ipAddress;

  EmployeeModel({
    this.id,
    this.username,
    this.email,
    this.active,
    this.jenisKelamin,
    this.type,
    this.educationLevel,
    this.eductionMajor,
    this.joinDate,
    this.birthDate,
    this.branch,
    this.outlet,
    this.location,
    this.job,
    this.section,
    this.ipAddress,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    active: json["active"] == null ? null : json["active"],
    jenisKelamin: json["jenisKelamin"] == null ? null : json["jenisKelamin"],
    type: json["type"] == null ? null : json["type"],
    educationLevel: json["educationLevel"] == null ? null : json["educationLevel"],
    eductionMajor: json["eductionMajor"] == null ? null : json["eductionMajor"],
    joinDate: json["joinDate"] == null ? null : json["joinDate"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    outlet: json["outlet"] == null ? null : Branch.fromJson(json["outlet"]),
    location: json["location"] == null ? null : Branch.fromJson(json["location"]),
    job: json["job"] == null ? null : Branch.fromJson(json["job"]),
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
    ipAddress: json["ipAddress"] == null ? null : json["ipAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "active": active == null ? null : active,
    "jenisKelamin": jenisKelamin == null ? null : jenisKelamin,
    "type": type == null ? null : type,
    "educationLevel": educationLevel == null ? null : educationLevel,
    "eductionMajor": eductionMajor == null ? null : eductionMajor,
    "joinDate": joinDate == null ? null : joinDate,
    "birthDate": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "branch": branch == null ? null : branch.toJson(),
    "outlet": outlet == null ? null : outlet.toJson(),
    "location": location == null ? null : location.toJson(),
    "job": job == null ? null : job.toJson(),
    "section": section == null ? null : section.toJson(),
    "ipAddress": ipAddress == null ? null : ipAddress,
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
