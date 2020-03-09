// To parse this JSON data, do
//
//     final assetKindModel = assetKindModelFromJson(jsonString);

import 'dart:convert';

AssetKindModel assetKindModelFromJson(String str) => AssetKindModel.fromJson(json.decode(str));

String assetKindModelToJson(AssetKindModel data) => json.encode(data.toJson());

class AssetKindModel {
  bool status;
  String message;
  List<Result> result;

  AssetKindModel({
    this.status,
    this.message,
    this.result,
  });

  factory AssetKindModel.fromJson(Map<String, dynamic> json) => AssetKindModel(
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
