// To parse this JSON data, do
//
//     final prospectModel = prospectModelFromJson(jsonString);

import 'dart:convert';

ProspectModel prospectModelFromJson(String str) => ProspectModel.fromJson(json.decode(str));

String prospectModelToJson(ProspectModel data) => json.encode(data.toJson());

class ProspectModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  ProspectModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory ProspectModel.fromJson(Map<String, dynamic> json) => ProspectModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    retCode: json["retCode"] == null ? null : json["retCode"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "retCode": retCode == null ? null : retCode,
    "token": token,
  };
}

class Datum {
  int prospectId;
  String prospectNum;
  int revisionNum;
  String leadCode;
  String cardCode;
  String cardName;
  int customerGroupId;
  int itemGroup;
  int salesCode;
  DateTime prospectDate;
  String prospectStatus;
  String prospectCanceled;
  String officeAreaCode;
  String officeBranchCode;
  String officeCode;
  int paymentTypeId;
  String tradeIn;
  String isFleet;
  int prospectSourceId;
  int prospectClassificationId;
  String prospectFirstVehicle;
  int prospectFollowup;
  String prospectComment;
  String sourceData;
  dynamic prospectCanceledDate;
  dynamic prospectCanceledComment;
  dynamic prospectCanceledUser;
  dynamic prospectAutoclosedDate;
  int createdUser;
  DateTime createdDate;
  String fromSuspect;
  dynamic models;
  dynamic followups;
  String salesName;
  String docStatus;
  String phone1;
  dynamic phone2;
  dynamic phone3;
  String location;
  String provinsiCode;
  String kabupatenCode;
  String kecamatanCode;
  String address1;
  String address2;
  String address3;
  String zipcode;
  String pekerjaan;
  String prospectClassificationName;
  dynamic prospectSourceName;
  dynamic canceledUser;

  Datum({
    this.prospectId,
    this.prospectNum,
    this.revisionNum,
    this.leadCode,
    this.cardCode,
    this.cardName,
    this.customerGroupId,
    this.itemGroup,
    this.salesCode,
    this.prospectDate,
    this.prospectStatus,
    this.prospectCanceled,
    this.officeAreaCode,
    this.officeBranchCode,
    this.officeCode,
    this.paymentTypeId,
    this.tradeIn,
    this.isFleet,
    this.prospectSourceId,
    this.prospectClassificationId,
    this.prospectFirstVehicle,
    this.prospectFollowup,
    this.prospectComment,
    this.sourceData,
    this.prospectCanceledDate,
    this.prospectCanceledComment,
    this.prospectCanceledUser,
    this.prospectAutoclosedDate,
    this.createdUser,
    this.createdDate,
    this.fromSuspect,
    this.models,
    this.followups,
    this.salesName,
    this.docStatus,
    this.phone1,
    this.phone2,
    this.phone3,
    this.location,
    this.provinsiCode,
    this.kabupatenCode,
    this.kecamatanCode,
    this.address1,
    this.address2,
    this.address3,
    this.zipcode,
    this.pekerjaan,
    this.prospectClassificationName,
    this.prospectSourceName,
    this.canceledUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    prospectNum: json["prospect_num"] == null ? null : json["prospect_num"],
    revisionNum: json["revision_num"] == null ? null : json["revision_num"],
    leadCode: json["lead_code"] == null ? null : json["lead_code"],
    cardCode: json["card_code"] == null ? null : json["card_code"],
    cardName: json["card_name"] == null ? null : json["card_name"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    salesCode: json["sales_code"] == null ? null : json["sales_code"],
    prospectDate: json["prospect_date"] == null ? null : DateTime.parse(json["prospect_date"]),
    prospectStatus: json["prospect_status"] == null ? null : json["prospect_status"],
    prospectCanceled: json["prospect_canceled"] == null ? null : json["prospect_canceled"],
    officeAreaCode: json["office_area_code"] == null ? null : json["office_area_code"],
    officeBranchCode: json["office_branch_code"] == null ? null : json["office_branch_code"],
    officeCode: json["office_code"] == null ? null : json["office_code"],
    paymentTypeId: json["payment_type_id"] == null ? null : json["payment_type_id"],
    tradeIn: json["trade_in"] == null ? null : json["trade_in"],
    isFleet: json["is_fleet"] == null ? null : json["is_fleet"],
    prospectSourceId: json["prospect_source_id"] == null ? null : json["prospect_source_id"],
    prospectClassificationId: json["prospect_classification_id"] == null ? null : json["prospect_classification_id"],
    prospectFirstVehicle: json["prospect_first_vehicle"] == null ? null : json["prospect_first_vehicle"],
    prospectFollowup: json["prospect_followup"] == null ? null : json["prospect_followup"],
    prospectComment: json["prospect_comment"] == null ? null : json["prospect_comment"],
    sourceData: json["source_data"] == null ? null : json["source_data"],
    prospectCanceledDate: json["prospect_canceled_date"],
    prospectCanceledComment: json["prospect_canceled_comment"],
    prospectCanceledUser: json["prospect_canceled_user"],
    prospectAutoclosedDate: json["prospect_autoclosed_date"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    fromSuspect: json["from_suspect"] == null ? null : json["from_suspect"],
    models: json["models"],
    followups: json["followups"],
    salesName: json["sales_name"] == null ? null : json["sales_name"],
    docStatus: json["docStatus"] == null ? null : json["docStatus"],
    phone1: json["phone1"] == null ? null : json["phone1"],
    phone2: json["phone2"],
    phone3: json["phone3"],
    location: json["location"] == null ? null : json["location"],
    provinsiCode: json["provinsi_code"] == null ? null : json["provinsi_code"],
    kabupatenCode: json["kabupaten_code"] == null ? null : json["kabupaten_code"],
    kecamatanCode: json["kecamatan_code"] == null ? null : json["kecamatan_code"],
    address1: json["address1"] == null ? null : json["address1"],
    address2: json["address2"] == null ? null : json["address2"],
    address3: json["address3"] == null ? null : json["address3"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    pekerjaan: json["pekerjaan"] == null ? null : json["pekerjaan"],
    prospectClassificationName: json["prospect_classification_name"] == null ? null : json["prospect_classification_name"],
    prospectSourceName: json["prospect_source_name"],
    canceledUser: json["canceled_user"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId == null ? null : prospectId,
    "prospect_num": prospectNum == null ? null : prospectNum,
    "revision_num": revisionNum == null ? null : revisionNum,
    "lead_code": leadCode == null ? null : leadCode,
    "card_code": cardCode == null ? null : cardCode,
    "card_name": cardName == null ? null : cardName,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "item_group": itemGroup == null ? null : itemGroup,
    "sales_code": salesCode == null ? null : salesCode,
    "prospect_date": prospectDate == null ? null : prospectDate.toIso8601String(),
    "prospect_status": prospectStatus == null ? null : prospectStatus,
    "prospect_canceled": prospectCanceled == null ? null : prospectCanceled,
    "office_area_code": officeAreaCode == null ? null : officeAreaCode,
    "office_branch_code": officeBranchCode == null ? null : officeBranchCode,
    "office_code": officeCode == null ? null : officeCode,
    "payment_type_id": paymentTypeId == null ? null : paymentTypeId,
    "trade_in": tradeIn == null ? null : tradeIn,
    "is_fleet": isFleet == null ? null : isFleet,
    "prospect_source_id": prospectSourceId == null ? null : prospectSourceId,
    "prospect_classification_id": prospectClassificationId == null ? null : prospectClassificationId,
    "prospect_first_vehicle": prospectFirstVehicle == null ? null : prospectFirstVehicle,
    "prospect_followup": prospectFollowup == null ? null : prospectFollowup,
    "prospect_comment": prospectComment == null ? null : prospectComment,
    "source_data": sourceData == null ? null : sourceData,
    "prospect_canceled_date": prospectCanceledDate,
    "prospect_canceled_comment": prospectCanceledComment,
    "prospect_canceled_user": prospectCanceledUser,
    "prospect_autoclosed_date": prospectAutoclosedDate,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "from_suspect": fromSuspect == null ? null : fromSuspect,
    "models": models,
    "followups": followups,
    "sales_name": salesName == null ? null : salesName,
    "docStatus": docStatus == null ? null : docStatus,
    "phone1": phone1 == null ? null : phone1,
    "phone2": phone2,
    "phone3": phone3,
    "location": location == null ? null : location,
    "provinsi_code": provinsiCode == null ? null : provinsiCode,
    "kabupaten_code": kabupatenCode == null ? null : kabupatenCode,
    "kecamatan_code": kecamatanCode == null ? null : kecamatanCode,
    "address1": address1 == null ? null : address1,
    "address2": address2 == null ? null : address2,
    "address3": address3 == null ? null : address3,
    "zipcode": zipcode == null ? null : zipcode,
    "pekerjaan": pekerjaan == null ? null : pekerjaan,
    "prospect_classification_name": prospectClassificationName == null ? null : prospectClassificationName,
    "prospect_source_name": prospectSourceName,
    "canceled_user": canceledUser,
  };
}
