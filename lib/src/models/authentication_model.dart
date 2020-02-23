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
  String jti;

  AuthenticationModel({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.jti,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) => AuthenticationModel(
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
    expiresIn: json["expires_in"] == null ? null : json["expires_in"],
    scope: json["scope"] == null ? null : json["scope"],
    jti: json["jti"] == null ? null : json["jti"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "refresh_token": refreshToken == null ? null : refreshToken,
    "expires_in": expiresIn == null ? null : expiresIn,
    "scope": scope == null ? null : scope,
    "jti": jti == null ? null : jti,
  };
}
