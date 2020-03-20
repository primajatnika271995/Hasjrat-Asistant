// To parse this JSON data, do
//
//     final class1ItemModel = class1ItemModelFromJson(jsonString);

import 'dart:convert';

Class1ItemModel class1ItemModelFromJson(String str) => Class1ItemModel.fromJson(json.decode(str));

String class1ItemModelToJson(Class1ItemModel data) => json.encode(data.toJson());

class Class1ItemModel {
  String status;
  List<String> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  Class1ItemModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory Class1ItemModel.fromJson(Map<String, dynamic> json) => Class1ItemModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    retCode: json["retCode"] == null ? null : json["retCode"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "retCode": retCode == null ? null : retCode,
    "token": token,
  };
}
