// To parse this JSON data, do
//
//     final spkNumberModel = spkNumberModelFromJson(jsonString);

import 'dart:convert';

SpkNumberModel spkNumberModelFromJson(String str) => SpkNumberModel.fromJson(json.decode(str));

String spkNumberModelToJson(SpkNumberModel data) => json.encode(data.toJson());

class SpkNumberModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  SpkNumberModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory SpkNumberModel.fromJson(Map<String, dynamic> json) => SpkNumberModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    retCode: json["retCode"] == null ? null : json["retCode"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "retCode": retCode == null ? null : retCode,
    "token": token,
  };
}

class Datum {
  int id;
  String spkNum;
  String spkBlanko;
  String officeAreaCode;
  String officeBranchCode;
  String officeCode;
  int itemGroup;
  int salesCode;
  String status;
  dynamic uploadedDocument;
  String isPrinted;
  dynamic printedUser;
  dynamic printedDate;
  String canceled;
  int createdUser;
  DateTime createdDate;
  int updatedUser;
  DateTime updatedDate;

  Datum({
    this.id,
    this.spkNum,
    this.spkBlanko,
    this.officeAreaCode,
    this.officeBranchCode,
    this.officeCode,
    this.itemGroup,
    this.salesCode,
    this.status,
    this.uploadedDocument,
    this.isPrinted,
    this.printedUser,
    this.printedDate,
    this.canceled,
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    spkNum: json["spk_num"] == null ? null : json["spk_num"],
    spkBlanko: json["spk_blanko"] == null ? null : json["spk_blanko"],
    officeAreaCode: json["office_area_code"] == null ? null : json["office_area_code"],
    officeBranchCode: json["office_branch_code"] == null ? null : json["office_branch_code"],
    officeCode: json["office_code"] == null ? null : json["office_code"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    salesCode: json["sales_code"] == null ? null : json["sales_code"],
    status: json["status"] == null ? null : json["status"],
    uploadedDocument: json["uploaded_document"],
    isPrinted: json["is_printed"] == null ? null : json["is_printed"],
    printedUser: json["printed_user"],
    printedDate: json["printed_date"],
    canceled: json["canceled"] == null ? null : json["canceled"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    updatedUser: json["updated_user"] == null ? null : json["updated_user"],
    updatedDate: json["updated_date"] == null ? null : DateTime.parse(json["updated_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "spk_num": spkNum == null ? null : spkNum,
    "spk_blanko": spkBlanko == null ? null : spkBlanko,
    "office_area_code": officeAreaCode == null ? null : officeAreaCode,
    "office_branch_code": officeBranchCode == null ? null : officeBranchCode,
    "office_code": officeCode == null ? null : officeCode,
    "item_group": itemGroup == null ? null : itemGroup,
    "sales_code": salesCode == null ? null : salesCode,
    "status": status == null ? null : status,
    "uploaded_document": uploadedDocument,
    "is_printed": isPrinted == null ? null : isPrinted,
    "printed_user": printedUser,
    "printed_date": printedDate,
    "canceled": canceled == null ? null : canceled,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "updated_user": updatedUser == null ? null : updatedUser,
    "updated_date": updatedDate == null ? null : updatedDate.toIso8601String(),
  };
}
