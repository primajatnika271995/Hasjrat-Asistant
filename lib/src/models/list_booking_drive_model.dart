// To parse this JSON data, do
//
//     final bookingDriveScheduleModel = bookingDriveScheduleModelFromJson(jsonString);

import 'dart:convert';

List<BookingDriveScheduleModel> bookingDriveScheduleModelFromJson(String str) => List<BookingDriveScheduleModel>.from(json.decode(str).map((x) => BookingDriveScheduleModel.fromJson(x)));

String bookingDriveScheduleModelToJson(List<BookingDriveScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingDriveScheduleModel {
    String id;
    String customerName;
    String customerPhone;
    Car car;
    String notes;
    String schedule;
    String branchCode;
    String outletCode;
    String createdBy;
    String createdDate;
    bool approve;
    dynamic approveBy;
    dynamic approveDate;
    bool checkedIn;
    dynamic checkedInDate;

    BookingDriveScheduleModel({
        this.id,
        this.customerName,
        this.customerPhone,
        this.car,
        this.notes,
        this.schedule,
        this.branchCode,
        this.outletCode,
        this.createdBy,
        this.createdDate,
        this.approve,
        this.approveBy,
        this.approveDate,
        this.checkedIn,
        this.checkedInDate,
    });

    factory BookingDriveScheduleModel.fromJson(Map<String, dynamic> json) => BookingDriveScheduleModel(
        id: json["id"] == null ? null : json["id"],
        customerName: json["customerName"] == null ? null : json["customerName"],
        customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
        car: json["car"] == null ? null : Car.fromJson(json["car"]),
        notes: json["notes"] == null ? null : json["notes"],
        schedule: json["schedule"] == null ? null : json["schedule"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        approve: json["approve"] == null ? null : json["approve"],
        approveBy: json["approveBy"],
        approveDate: json["approveDate"],
        checkedIn: json["checkedIn"] == null ? null : json["checkedIn"],
        checkedInDate: json["checkedInDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customerName": customerName == null ? null : customerName,
        "customerPhone": customerPhone == null ? null : customerPhone,
        "car": car == null ? null : car.toJson(),
        "notes": notes == null ? null : notes,
        "schedule": schedule == null ? null : schedule,
        "branchCode": branchCode == null ? null : branchCode,
        "outletCode": outletCode == null ? null : outletCode,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "approve": approve == null ? null : approve,
        "approveBy": approveBy,
        "approveDate": approveDate,
        "checkedIn": checkedIn == null ? null : checkedIn,
        "checkedInDate": checkedInDate,
    };
}

class Car {
    String id;
    String itemModel;
    String itemType;
    String itemClass;
    dynamic itemClass1;
    String colorId;
    String colorNameEn;
    String colorNameId;
    String noPolisi;
    String branchCode;
    String outletCode;
    String createdBy;
    String createdDate;
    bool enabled;

    Car({
        this.id,
        this.itemModel,
        this.itemType,
        this.itemClass,
        this.itemClass1,
        this.colorId,
        this.colorNameEn,
        this.colorNameId,
        this.noPolisi,
        this.branchCode,
        this.outletCode,
        this.createdBy,
        this.createdDate,
        this.enabled,
    });

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"] == null ? null : json["id"],
        itemModel: json["itemModel"] == null ? null : json["itemModel"],
        itemType: json["itemType"] == null ? null : json["itemType"],
        itemClass: json["itemClass"] == null ? null : json["itemClass"],
        itemClass1: json["itemClass1"],
        colorId: json["colorId"] == null ? null : json["colorId"],
        colorNameEn: json["colorNameEN"] == null ? null : json["colorNameEN"],
        colorNameId: json["colorNameID"] == null ? null : json["colorNameID"],
        noPolisi: json["noPolisi"] == null ? null : json["noPolisi"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        outletCode: json["outletCode"] == null ? null : json["outletCode"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        enabled: json["enabled"] == null ? null : json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "itemModel": itemModel == null ? null : itemModel,
        "itemType": itemType == null ? null : itemType,
        "itemClass": itemClass == null ? null : itemClass,
        "itemClass1": itemClass1,
        "colorId": colorId == null ? null : colorId,
        "colorNameEN": colorNameEn == null ? null : colorNameEn,
        "colorNameID": colorNameId == null ? null : colorNameId,
        "noPolisi": noPolisi == null ? null : noPolisi,
        "branchCode": branchCode == null ? null : branchCode,
        "outletCode": outletCode == null ? null : outletCode,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate": createdDate == null ? null : createdDate,
        "enabled": enabled == null ? null : enabled,
    };
}
