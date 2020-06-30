// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    DashboardModel({
        this.status,
        this.data,
        this.error,
        this.message,
        this.retCode,
        this.token,
    });

    String status;
    Data data;
    String error;
    String message;
    int retCode;
    dynamic token;

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        retCode: json["retCode"] == null ? null : json["retCode"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "retCode": retCode == null ? null : retCode,
        "token": token,
    };
}

class Data {
    Data({
        this.salesCode,
        this.salesName,
        this.rekaps,
    });

    int salesCode;
    String salesName;
    List<Rekap> rekaps;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        salesCode: json["sales_code"] == null ? null : json["sales_code"],
        salesName: json["sales_name"] == null ? null : json["sales_name"],
        rekaps: json["rekaps"] == null ? null : List<Rekap>.from(json["rekaps"].map((x) => Rekap.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sales_code": salesCode == null ? null : salesCode,
        "sales_name": salesName == null ? null : salesName,
        "rekaps": rekaps == null ? null : List<dynamic>.from(rekaps.map((x) => x.toJson())),
    };
}

class Rekap {
    Rekap({
        this.yearmonth,
        this.contact,
        this.prospect,
        this.hotprospect,
        this.spk,
        this.deliveryOrder,
        this.dec,
    });

    String yearmonth;
    int contact;
    int prospect;
    int hotprospect;
    int spk;
    int deliveryOrder;
    int dec;

    factory Rekap.fromJson(Map<String, dynamic> json) => Rekap(
        yearmonth: json["yearmonth"] == null ? null : json["yearmonth"],
        contact: json["contact"] == null ? null : json["contact"],
        prospect: json["prospect"] == null ? null : json["prospect"],
        hotprospect: json["hotprospect"] == null ? null : json["hotprospect"],
        spk: json["spk"] == null ? null : json["spk"],
        deliveryOrder: json["deliveryOrder"] == null ? null : json["deliveryOrder"],
        dec: json["dec"] == null ? null : json["dec"],
    );

    Map<String, dynamic> toJson() => {
        "yearmonth": yearmonth == null ? null : yearmonth,
        "contact": contact == null ? null : contact,
        "prospect": prospect == null ? null : prospect,
        "hotprospect": hotprospect == null ? null : hotprospect,
        "spk": spk == null ? null : spk,
        "deliveryOrder": deliveryOrder == null ? null : deliveryOrder,
        "dec": dec == null ? null : dec,
    };
}
