// To parse this JSON data, do
//
//     final uploadMediaModel = uploadMediaModelFromJson(jsonString);

import 'dart:convert';

UploadMediaModel uploadMediaModelFromJson(String str) => UploadMediaModel.fromJson(json.decode(str));

String uploadMediaModelToJson(UploadMediaModel data) => json.encode(data.toJson());

class UploadMediaModel {
  String id;
  String filename;
  String extension;
  String path;
  String url;

  UploadMediaModel({
    this.id,
    this.filename,
    this.extension,
    this.path,
    this.url,
  });

  factory UploadMediaModel.fromJson(Map<String, dynamic> json) => UploadMediaModel(
    id: json["id"] == null ? null : json["id"],
    filename: json["filename"] == null ? null : json["filename"],
    extension: json["extension"] == null ? null : json["extension"],
    path: json["path"] == null ? null : json["path"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "filename": filename == null ? null : filename,
    "extension": extension == null ? null : extension,
    "path": path == null ? null : path,
    "url": url == null ? null : url,
  };
}
