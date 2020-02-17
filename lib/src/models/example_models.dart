// To parse this JSON data, do
//
//     final authenticated = authenticatedFromJson(jsonString);

import 'dart:convert';

ExampleModel authenticatedFromJson(String str) => ExampleModel.fromJson(json.decode(str));

String exampleToJson(ExampleModel data) => json.encode(data.toJson());

class ExampleModel {
  String accessToken;

  ExampleModel({
    this.accessToken,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) => ExampleModel(
    accessToken: json["access_token"] == null ? null : json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
  };
}
