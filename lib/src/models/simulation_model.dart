// To parse this JSON data, do
//
//     final simulationModel = simulationModelFromJson(jsonString);

import 'dart:convert';

SimulationModel simulationModelFromJson(String str) => SimulationModel.fromJson(json.decode(str));

String simulationModelToJson(SimulationModel data) => json.encode(data.toJson());

class SimulationModel {
  bool status;
  String message;
  List<Result> result;

  SimulationModel({
    this.status,
    this.message,
    this.result,
  });

  factory SimulationModel.fromJson(Map<String, dynamic> json) => SimulationModel(
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
  String tenorName;
  String downPayment;
  String installment;
  int tenorVale;

  Result({
    this.tenorName,
    this.downPayment,
    this.installment,
    this.tenorVale,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    tenorName: json["tenorName"] == null ? null : json["tenorName"],
    downPayment: json["downPayment"] == null ? null : json["downPayment"],
    installment: json["installment"] == null ? null : json["installment"],
    tenorVale: json["tenorVale"] == null ? null : json["tenorVale"],
  );

  Map<String, dynamic> toJson() => {
    "tenorName": tenorName == null ? null : tenorName,
    "downPayment": downPayment == null ? null : downPayment,
    "installment": installment == null ? null : installment,
    "tenorVale": tenorVale == null ? null : tenorVale,
  };
}
