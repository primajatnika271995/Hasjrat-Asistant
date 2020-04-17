// To parse this JSON data, do
//
//     final serviceStationModel = serviceStationModelFromJson(jsonString);

import 'dart:convert';

List<ServiceStationModel> serviceStationModelFromJson(String str) => List<ServiceStationModel>.from(json.decode(str).map((x) => ServiceStationModel.fromJson(x)));

String serviceStationModelToJson(List<ServiceStationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceStationModel {
  String id;
  String name;
  String address;
  String longitude;
  String latitude;
  String rating;
  dynamic image;
  String showOnChat;
  String createdDate;
  String username;
  String idDealerLocation;
  dynamic contact;
  String email;
  dynamic openTime;
  dynamic closeTime;

  ServiceStationModel({
    this.id,
    this.name,
    this.address,
    this.longitude,
    this.latitude,
    this.rating,
    this.image,
    this.showOnChat,
    this.createdDate,
    this.username,
    this.idDealerLocation,
    this.contact,
    this.email,
    this.openTime,
    this.closeTime,
  });

  factory ServiceStationModel.fromJson(Map<String, dynamic> json) => ServiceStationModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    rating: json["rating"] == null ? null : json["rating"],
    image: json["image"],
    showOnChat: json["showOnChat"] == null ? null : json["showOnChat"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    username: json["username"] == null ? null : json["username"],
    idDealerLocation: json["idDealerLocation"] == null ? null : json["idDealerLocation"],
    contact: json["contact"],
    email: json["email"] == null ? null : json["email"],
    openTime: json["openTime"],
    closeTime: json["closeTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "rating": rating == null ? null : rating,
    "image": image,
    "showOnChat": showOnChat == null ? null : showOnChat,
    "createdDate": createdDate == null ? null : createdDate,
    "username": username == null ? null : username,
    "idDealerLocation": idDealerLocation == null ? null : idDealerLocation,
    "contact": contact,
    "email": email == null ? null : email,
    "openTime": openTime,
    "closeTime": closeTime,
  };
}
