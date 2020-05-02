// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    String status;
    Data data;
    String error;
    String message;
    int retCode;
    dynamic token;

    DashboardModel({
        this.status,
        this.data,
        this.error,
        this.message,
        this.retCode,
        this.token,
    });

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
    int salesCode;
    String salesName;
    List<Contact> contacts;
    List<Contact> prospects;
    List<Contact> hotprospects;
    List<Contact> spks;
    List<Contact> deliveries;

    Data({
        this.salesCode,
        this.salesName,
        this.contacts,
        this.prospects,
        this.hotprospects,
        this.spks,
        this.deliveries,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        salesCode: json["sales_code"] == null ? null : json["sales_code"],
        salesName: json["sales_name"] == null ? null : json["sales_name"],
        contacts: json["contacts"] == null ? null : List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
        prospects: json["prospects"] == null ? null : List<Contact>.from(json["prospects"].map((x) => Contact.fromJson(x))),
        hotprospects: json["hotprospects"] == null ? null : List<Contact>.from(json["hotprospects"].map((x) => Contact.fromJson(x))),
        spks: json["spks"] == null ? null : List<Contact>.from(json["spks"].map((x) => Contact.fromJson(x))),
        deliveries: json["deliveries"] == null ? null : List<Contact>.from(json["deliveries"].map((x) => Contact.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sales_code": salesCode == null ? null : salesCode,
        "sales_name": salesName == null ? null : salesName,
        "contacts": contacts == null ? null : List<dynamic>.from(contacts.map((x) => x.toJson())),
        "prospects": prospects == null ? null : List<dynamic>.from(prospects.map((x) => x.toJson())),
        "hotprospects": hotprospects == null ? null : List<dynamic>.from(hotprospects.map((x) => x.toJson())),
        "spks": spks == null ? null : List<dynamic>.from(spks.map((x) => x.toJson())),
        "deliveries": deliveries == null ? null : List<dynamic>.from(deliveries.map((x) => x.toJson())),
    };
}

class Contact {
    String yearmonth;
    int total;

    Contact({
        this.yearmonth,
        this.total,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        yearmonth: json["yearmonth"] == null ? null : json["yearmonth"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "yearmonth": yearmonth == null ? null : yearmonth,
        "total": total == null ? null : total,
    };
}
