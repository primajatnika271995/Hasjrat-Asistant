// To parse this JSON data, do
//
//     final classificationFollowUpModel = classificationFollowUpModelFromJson(jsonString);

import 'dart:convert';

ClassificationFollowUpModel classificationFollowUpModelFromJson(String str) => ClassificationFollowUpModel.fromJson(json.decode(str));

String classificationFollowUpModelToJson(ClassificationFollowUpModel data) => json.encode(data.toJson());

class ClassificationFollowUpModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  ClassificationFollowUpModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory ClassificationFollowUpModel.fromJson(Map<String, dynamic> json) => ClassificationFollowUpModel(
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
  int prospectClassificationId;
  String prospectClassificationName;

  Datum({
    this.prospectClassificationId,
    this.prospectClassificationName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    prospectClassificationId: json["prospect_classification_id"] == null ? null : json["prospect_classification_id"],
    prospectClassificationName: json["prospect_classification_name"] == null ? null : json["prospect_classification_name"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_classification_id": prospectClassificationId == null ? null : prospectClassificationId,
    "prospect_classification_name": prospectClassificationName == null ? null : prospectClassificationName,
  };
}
