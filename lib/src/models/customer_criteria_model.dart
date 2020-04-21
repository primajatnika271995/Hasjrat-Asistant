// To parse this JSON data, do
//
//     final customerCriteriaModel = customerCriteriaModelFromJson(jsonString);

import 'dart:convert';

CustomerCriteriaModel customerCriteriaModelFromJson(String str) => CustomerCriteriaModel.fromJson(json.decode(str));

String customerCriteriaModelToJson(CustomerCriteriaModel data) => json.encode(data.toJson());

class CustomerCriteriaModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  CustomerCriteriaModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory CustomerCriteriaModel.fromJson(Map<String, dynamic> json) => CustomerCriteriaModel(
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
  int customerCriteriaId;
  String customerCriteriaName;
  String itemGroup;
  String status;
  String isDeleted;

  Datum({
    this.customerCriteriaId,
    this.customerCriteriaName,
    this.itemGroup,
    this.status,
    this.isDeleted,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    customerCriteriaId: json["customer_criteria_id"] == null ? null : json["customer_criteria_id"],
    customerCriteriaName: json["customer_criteria_name"] == null ? null : json["customer_criteria_name"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    status: json["status"] == null ? null : json["status"],
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "customer_criteria_id": customerCriteriaId == null ? null : customerCriteriaId,
    "customer_criteria_name": customerCriteriaName == null ? null : customerCriteriaName,
    "item_group": itemGroup == null ? null : itemGroup,
    "status": status == null ? null : status,
    "is_deleted": isDeleted == null ? null : isDeleted,
  };
}
