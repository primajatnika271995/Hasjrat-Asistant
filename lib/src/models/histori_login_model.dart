// To parse this JSON data, do
//
//     final historiLoginModel = historiLoginModelFromJson(jsonString);

import 'dart:convert';

HistoriLoginModel historiLoginModelFromJson(String str) => HistoriLoginModel.fromJson(json.decode(str));

String historiLoginModelToJson(HistoriLoginModel data) => json.encode(data.toJson());

class HistoriLoginModel {
  HistoriLoginModel({
    this.id,
    this.employeeId,
    this.branchCode,
    this.branchName,
    this.outletCode,
    this.outletName,
    this.isLogin,
    this.loginDate,
    this.logoutDate,
    this.createdBy,
  });

  String id;
  String employeeId;
  String branchCode;
  String branchName;
  String outletCode;
  String outletName;
  bool isLogin;
  String loginDate;
  dynamic logoutDate;
  String createdBy;

  factory HistoriLoginModel.fromJson(Map<String, dynamic> json) => HistoriLoginModel(
    id: json["id"] == null ? null : json["id"],
    employeeId: json["employeeId"] == null ? null : json["employeeId"],
    branchCode: json["branchCode"] == null ? null : json["branchCode"],
    branchName: json["branchName"] == null ? null : json["branchName"],
    outletCode: json["outletCode"] == null ? null : json["outletCode"],
    outletName: json["outletName"] == null ? null : json["outletName"],
    isLogin: json["isLogin"] == null ? null : json["isLogin"],
    loginDate: json["loginDate"] == null ? null : json["loginDate"],
    logoutDate: json["logoutDate"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "employeeId": employeeId == null ? null : employeeId,
    "branchCode": branchCode == null ? null : branchCode,
    "branchName": branchName == null ? null : branchName,
    "outletCode": outletCode == null ? null : outletCode,
    "outletName": outletName == null ? null : outletName,
    "isLogin": isLogin == null ? null : isLogin,
    "loginDate": loginDate == null ? null : loginDate,
    "logoutDate": logoutDate,
    "createdBy": createdBy == null ? null : createdBy,
  };
}
