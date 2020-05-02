// To parse this JSON data, do
//
//     final targetDashboardModel = targetDashboardModelFromJson(jsonString);

import 'dart:convert';

TargetDashboardModel targetDashboardModelFromJson(String str) => TargetDashboardModel.fromJson(json.decode(str));

String targetDashboardModelToJson(TargetDashboardModel data) => json.encode(data.toJson());

class TargetDashboardModel {
    String outletCode;
    String branchCode;
    double totalSoldCar;
    double targetSoldCar;
    double totalProfitAmount;

    TargetDashboardModel({
        this.outletCode,
        this.branchCode,
        this.totalSoldCar,
        this.targetSoldCar,
        this.totalProfitAmount,
    });

    factory TargetDashboardModel.fromJson(Map<String, dynamic> json) => TargetDashboardModel(
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        totalSoldCar: json["totalSoldCar"] == null ? null : json["totalSoldCar"].toDouble(),
        targetSoldCar: json["targetSoldCar"] == null ? null : json["targetSoldCar"].toDouble(),
        totalProfitAmount: json["totalProfitAmount"] == null ? null : json["totalProfitAmount"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "outletCode": outletCode == null ? null : outletCode,
        "branchCode": branchCode == null ? null : branchCode,
        "totalSoldCar": totalSoldCar == null ? null : totalSoldCar,
        "targetSoldCar": targetSoldCar == null ? null : targetSoldCar,
        "totalProfitAmount": totalProfitAmount == null ? null : totalProfitAmount,
    };
}
