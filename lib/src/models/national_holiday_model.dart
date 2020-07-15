// To parse this JSON data, do
//
//     final nationalHolidayModel = nationalHolidayModelFromJson(jsonString);

import 'dart:convert';

List<NationalHolidayModel> nationalHolidayModelFromJson(String str) => List<NationalHolidayModel>.from(json.decode(str).map((x) => NationalHolidayModel.fromJson(x)));

String nationalHolidayModelToJson(List<NationalHolidayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NationalHolidayModel {
  NationalHolidayModel({
    this.date,
    this.description,
    this.type,
  });

  DateTime date;
  String description;
  Type type;

  factory NationalHolidayModel.fromJson(Map<String, dynamic> json) => NationalHolidayModel(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    type: json["type"] == null ? null : typeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "description": description == null ? null : description,
    "type": type == null ? null : typeValues.reverse[type],
  };
}

enum Type { NATIONAL_HOLIDAY, JOINT_HOLIDAY }

final typeValues = EnumValues({
  "joint-holiday": Type.JOINT_HOLIDAY,
  "national-holiday": Type.NATIONAL_HOLIDAY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
