// To parse this JSON data, do
//
//     final knowladgeBaseModel = knowladgeBaseModelFromJson(jsonString);

import 'dart:convert';

KnowladgeBaseModel knowladgeBaseModelFromJson(String str) => KnowladgeBaseModel.fromJson(json.decode(str));

String knowladgeBaseModelToJson(KnowladgeBaseModel data) => json.encode(data.toJson());

class KnowladgeBaseModel {
  List<Datum> data;
  int draw;
  int recordsTotal;
  int recordsFiltered;

  KnowladgeBaseModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  factory KnowladgeBaseModel.fromJson(Map<String, dynamic> json) => KnowladgeBaseModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    draw: json["draw"] == null ? null : json["draw"],
    recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "draw": draw == null ? null : draw,
    "recordsTotal": recordsTotal == null ? null : recordsTotal,
    "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
  };
}

class Datum {
  String id;
  String question;
  String answer;
  dynamic urlFile;
  Category category;
  bool draft;
  bool publish;
  int likeCount;
  String createdBy;
  String createdDate;
  String lastUpdatedBy;
  dynamic lastUpdatedDate;

  Datum({
    this.id,
    this.question,
    this.answer,
    this.urlFile,
    this.category,
    this.draft,
    this.publish,
    this.likeCount,
    this.createdBy,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    question: json["question"] == null ? null : json["question"],
    answer: json["answer"] == null ? null : json["answer"],
    urlFile: json["urlFile"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    draft: json["draft"] == null ? null : json["draft"],
    publish: json["publish"] == null ? null : json["publish"],
    likeCount: json["likeCount"] == null ? null : json["likeCount"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    lastUpdatedBy: json["lastUpdatedBy"] == null ? null : json["lastUpdatedBy"],
    lastUpdatedDate: json["lastUpdatedDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "question": question == null ? null : question,
    "answer": answer == null ? null : answer,
    "urlFile": urlFile,
    "category": category == null ? null : category.toJson(),
    "draft": draft == null ? null : draft,
    "publish": publish == null ? null : publish,
    "likeCount": likeCount == null ? null : likeCount,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate,
    "lastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
    "lastUpdatedDate": lastUpdatedDate,
  };
}

class Category {
  String id;
  String name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
