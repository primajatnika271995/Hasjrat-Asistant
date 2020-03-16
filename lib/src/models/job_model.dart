// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';

JobModel jobModelFromJson(String str) => JobModel.fromJson(json.decode(str));

String jobModelToJson(JobModel data) => json.encode(data.toJson());

class JobModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  JobModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
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
  String aliasId;
  String tableId;
  int fieldId;
  int indexId;
  String fldValue;
  String descr;

  Datum({
    this.aliasId,
    this.tableId,
    this.fieldId,
    this.indexId,
    this.fldValue,
    this.descr,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    aliasId: json["AliasID"] == null ? null : json["AliasID"],
    tableId: json["TableID"] == null ? null : json["TableID"],
    fieldId: json["FieldID"] == null ? null : json["FieldID"],
    indexId: json["IndexID"] == null ? null : json["IndexID"],
    fldValue: json["FldValue"] == null ? null : json["FldValue"],
    descr: json["Descr"] == null ? null : json["Descr"],
  );

  Map<String, dynamic> toJson() => {
    "AliasID": aliasId == null ? null : aliasId,
    "TableID": tableId == null ? null : tableId,
    "FieldID": fieldId == null ? null : fieldId,
    "IndexID": indexId == null ? null : indexId,
    "FldValue": fldValue == null ? null : fldValue,
    "Descr": descr == null ? null : descr,
  };
}
