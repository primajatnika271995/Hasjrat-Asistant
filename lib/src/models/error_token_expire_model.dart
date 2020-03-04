// To parse this JSON data, do
//
//     final errorTokenExpire = errorTokenExpireFromJson(jsonString);

import 'dart:convert';

ErrorTokenExpire errorTokenExpireFromJson(String str) => ErrorTokenExpire.fromJson(json.decode(str));

String errorTokenExpireToJson(ErrorTokenExpire data) => json.encode(data.toJson());

class ErrorTokenExpire {
  String error;
  String errorDescription;

  ErrorTokenExpire({
    this.error,
    this.errorDescription,
  });

  factory ErrorTokenExpire.fromJson(Map<String, dynamic> json) => ErrorTokenExpire(
    error: json["error"] == null ? null : json["error"],
    errorDescription: json["error_description"] == null ? null : json["error_description"],
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "error_description": errorDescription == null ? null : errorDescription,
  };
}
