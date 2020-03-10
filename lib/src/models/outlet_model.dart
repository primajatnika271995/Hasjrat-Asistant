// To parse this JSON data, do
//
//     final outletModel = outletModelFromJson(jsonString);

import 'dart:convert';

OutletModel outletModelFromJson(String str) => OutletModel.fromJson(json.decode(str));

String outletModelToJson(OutletModel data) => json.encode(data.toJson());

class OutletModel {
  bool status;
  String message;
  List<Result> result;

  OutletModel({
    this.status,
    this.message,
    this.result,
  });

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "result": result == null ? null : List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String id;
  String text;

  Result({
    this.id,
    this.text,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
  };
}
