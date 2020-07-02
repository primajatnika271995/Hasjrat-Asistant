// To parse this JSON data, do
//
//     final targetDashboardModel = targetDashboardModelFromJson(jsonString);

import 'dart:convert';

List<TargetDashboardModel> targetDashboardModelFromJson(String str) => List<TargetDashboardModel>.from(json.decode(str).map((x) => TargetDashboardModel.fromJson(x)));

String targetDashboardModelToJson(List<TargetDashboardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TargetDashboardModel {
    TargetDashboardModel({
        this.employeeId,
        this.bulan,
        this.customerGroup,
        this.totalSoldCar,
        this.targetSoldCar,
        this.totalProfitAmount,
        this.spv,
    });

    String employeeId;
    String bulan;
    String customerGroup;
    double totalSoldCar;
    double targetSoldCar;
    double totalProfitAmount;
    bool spv;

    factory TargetDashboardModel.fromJson(Map<String, dynamic> json) => TargetDashboardModel(
        employeeId: json["employeeId"] == null ? null : json["employeeId"],
        bulan: json["bulan"] == null ? null : json["bulan"],
        customerGroup: json["customerGroup"] == null ? null : json["customerGroup"],
        totalSoldCar: json["totalSoldCar"] == null ? null : json["totalSoldCar"].toDouble(),
        targetSoldCar: json["targetSoldCar"] == null ? null : json["targetSoldCar"].toDouble(),
        totalProfitAmount: json["totalProfitAmount"] == null ? null : json["totalProfitAmount"].toDouble(),
        spv: json["spv"] == null ? null : json["spv"],
    );

    Map<String, dynamic> toJson() => {
        "employeeId": employeeId == null ? null : employeeId,
        "bulan": bulan == null ? null : bulan,
        "customerGroup": customerGroup == null ? null : customerGroup,
        "totalSoldCar": totalSoldCar == null ? null : totalSoldCar,
        "targetSoldCar": targetSoldCar == null ? null : targetSoldCar,
        "totalProfitAmount": totalProfitAmount == null ? null : totalProfitAmount,
        "spv": spv == null ? null : spv,
    };
}
