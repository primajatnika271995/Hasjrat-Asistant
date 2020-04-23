// To parse this JSON data, do
//
//     final followUpMethodeModel = followUpMethodeModelFromJson(jsonString);

import 'dart:convert';

FollowUpMethodeModel followUpMethodeModelFromJson(String str) => FollowUpMethodeModel.fromJson(json.decode(str));

String followUpMethodeModelToJson(FollowUpMethodeModel data) => json.encode(data.toJson());

class FollowUpMethodeModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  FollowUpMethodeModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory FollowUpMethodeModel.fromJson(Map<String, dynamic> json) => FollowUpMethodeModel(
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
  int followupMethodId;
  String followupMethodName;

  Datum({
    this.followupMethodId,
    this.followupMethodName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    followupMethodId: json["followup_method_id"] == null ? null : json["followup_method_id"],
    followupMethodName: json["followup_method_name"] == null ? null : json["followup_method_name"],
  );

  Map<String, dynamic> toJson() => {
    "followup_method_id": followupMethodId == null ? null : followupMethodId,
    "followup_method_name": followupMethodName == null ? null : followupMethodName,
  };
}
