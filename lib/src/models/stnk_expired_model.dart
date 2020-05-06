// To parse this JSON data, do
//
//     final stnkExpiredModel = stnkExpiredModelFromJson(jsonString);

import 'dart:convert';

List<StnkExpiredModel> stnkExpiredModelFromJson(String str) => List<StnkExpiredModel>.from(json.decode(str).map((x) => StnkExpiredModel.fromJson(x)));

String stnkExpiredModelToJson(List<StnkExpiredModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StnkExpiredModel {
  String customerName;
  String phone;
  String carName;
  String carColor;
  String chassisNumber;
  String machineNumber;
  String expiredDateStnk;

  StnkExpiredModel({
    this.customerName,
    this.phone,
    this.carName,
    this.carColor,
    this.chassisNumber,
    this.machineNumber,
    this.expiredDateStnk,
  });

  factory StnkExpiredModel.fromJson(Map<String, dynamic> json) => StnkExpiredModel(
    customerName: json["customerName"] == null ? null : json["customerName"],
    phone: json["phone"] == null ? null : json["phone"],
    carName: json["carName"] == null ? null : json["carName"],
    carColor: json["carColor"] == null ? null : json["carColor"],
    chassisNumber: json["chassisNumber"] == null ? null : json["chassisNumber"],
    machineNumber: json["machineNumber"] == null ? null : json["machineNumber"],
    expiredDateStnk: json["expiredDateStnk"] == null ? null : json["expiredDateStnk"],
  );

  Map<String, dynamic> toJson() => {
    "customerName": customerName == null ? null : customerName,
    "phone": phone == null ? null : phone,
    "carName": carName == null ? null : carName,
    "carColor": carColor == null ? null : carColor,
    "chassisNumber": chassisNumber == null ? null : chassisNumber,
    "machineNumber": machineNumber == null ? null : machineNumber,
    "expiredDateStnk": expiredDateStnk == null ? null : expiredDateStnk,
  };
}
