// To parse this JSON data, do
//
//     final authenticationModel = authenticationModelFromJson(jsonString);

import 'dart:convert';

AuthenticationModel authenticationModelFromJson(String str) => AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) => json.encode(data.toJson());

class AuthenticationModel {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  String branchCode;
  String employeeId;
  String outletCode;
  String jti;
  String error;
  String errorDescription;

  AuthenticationModel({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.branchCode,
    this.employeeId,
    this.outletCode,
    this.jti,
    this.error,
    this.errorDescription,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) => AuthenticationModel(
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
    expiresIn: json["expires_in"] == null ? null : json["expires_in"],
    scope: json["scope"] == null ? null : json["scope"],
    branchCode: json["branchCode"] == null ? null : json["branchCode"],
    employeeId: json["employeeId"] == null ? null : json["employeeId"],
    outletCode: json["outletCode"] == null ? null : json["outletCode"],
    jti: json["jti"] == null ? null : json["jti"],
    error: json["error"] == null ? null : json["error"],
    errorDescription: json["error_description"] == null ? null : json["error_description"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "refresh_token": refreshToken == null ? null : refreshToken,
    "expires_in": expiresIn == null ? null : expiresIn,
    "scope": scope == null ? null : scope,
    "branchCode": branchCode == null ? null : branchCode,
    "employeeId": employeeId == null ? null : employeeId,
    "outletCode": outletCode == null ? null : outletCode,
    "jti": jti == null ? null : jti,
    "error": error == null ? null : error,
    "error_description": errorDescription == null ? null : errorDescription,
  };
}
