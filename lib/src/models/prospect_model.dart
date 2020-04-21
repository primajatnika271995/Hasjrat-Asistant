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
  dynamic prospectDate;
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
  dynamic prospectComment;
  String sourceData;
  dynamic prospectCanceledDate;
  dynamic prospectCanceledComment;
  dynamic prospectCanceledUser;
  dynamic prospectAutoclosedDate;
  int createdUser;
  DateTime createdDate;
  String fromSuspect;
  List<Model> models;
  List<Followup> followups;
  String salesName;
  String docStatus;
  String phone1;
  String phone2;
  String phone3;
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
  String prospectSourceName;
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
    prospectDate: json["prospect_date"],
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
    prospectComment: json["prospect_comment"],
    sourceData: json["source_data"] == null ? null : json["source_data"],
    prospectCanceledDate: json["prospect_canceled_date"],
    prospectCanceledComment: json["prospect_canceled_comment"],
    prospectCanceledUser: json["prospect_canceled_user"],
    prospectAutoclosedDate: json["prospect_autoclosed_date"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    fromSuspect: json["from_suspect"] == null ? null : json["from_suspect"],
    models: json["models"] == null ? null : List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
    followups: json["followups"] == null ? null : List<Followup>.from(json["followups"].map((x) => Followup.fromJson(x))),
    salesName: json["sales_name"] == null ? null : json["sales_name"],
    docStatus: json["docStatus"] == null ? null : json["docStatus"],
    phone1: json["phone1"] == null ? null : json["phone1"],
    phone2: json["phone2"] == null ? null : json["phone2"],
    phone3: json["phone3"] == null ? null : json["phone3"],
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
    prospectSourceName: json["prospect_source_name"] == null ? null : json["prospect_source_name"],
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
    "prospect_date": prospectDate,
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
    "prospect_comment": prospectComment,
    "source_data": sourceData == null ? null : sourceData,
    "prospect_canceled_date": prospectCanceledDate,
    "prospect_canceled_comment": prospectCanceledComment,
    "prospect_canceled_user": prospectCanceledUser,
    "prospect_autoclosed_date": prospectAutoclosedDate,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "from_suspect": fromSuspect == null ? null : fromSuspect,
    "models": models == null ? null : List<dynamic>.from(models.map((x) => x.toJson())),
    "followups": followups == null ? null : List<dynamic>.from(followups.map((x) => x.toJson())),
    "sales_name": salesName == null ? null : salesName,
    "docStatus": docStatus == null ? null : docStatus,
    "phone1": phone1 == null ? null : phone1,
    "phone2": phone2 == null ? null : phone2,
    "phone3": phone3 == null ? null : phone3,
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
    "prospect_source_name": prospectSourceName == null ? null : prospectSourceName,
    "canceled_user": canceledUser,
  };
}

class Followup {
  int prospectFollowupId;
  int prospectId;
  int lineNum;
  DateTime followupPlanDate;
  dynamic followupActualDate;
  int followupNextDay;
  dynamic prospectClassificationId;
  dynamic prospectFollowupMethodId;
  dynamic prospectRemarks;
  int createdUser;
  DateTime createdDate;
  dynamic updatedUser;
  dynamic updatedDate;
  dynamic prospectClassificationName;
  dynamic followupMethodName;

  Followup({
    this.prospectFollowupId,
    this.prospectId,
    this.lineNum,
    this.followupPlanDate,
    this.followupActualDate,
    this.followupNextDay,
    this.prospectClassificationId,
    this.prospectFollowupMethodId,
    this.prospectRemarks,
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
    this.prospectClassificationName,
    this.followupMethodName,
  });

  factory Followup.fromJson(Map<String, dynamic> json) => Followup(
    prospectFollowupId: json["prospect_followup_id"] == null ? null : json["prospect_followup_id"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    lineNum: json["line_num"] == null ? null : json["line_num"],
    followupPlanDate: json["followup_plan_date"] == null ? null : DateTime.parse(json["followup_plan_date"]),
    followupActualDate: json["followup_actual_date"],
    followupNextDay: json["followup_next_day"] == null ? null : json["followup_next_day"],
    prospectClassificationId: json["prospect_classification_id"],
    prospectFollowupMethodId: json["prospect_followup_method_id"],
    prospectRemarks: json["prospect_remarks"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    updatedUser: json["updated_user"],
    updatedDate: json["updated_date"],
    prospectClassificationName: json["prospect_classification_name"],
    followupMethodName: json["followup_method_name"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_followup_id": prospectFollowupId == null ? null : prospectFollowupId,
    "prospect_id": prospectId == null ? null : prospectId,
    "line_num": lineNum == null ? null : lineNum,
    "followup_plan_date": followupPlanDate == null ? null : followupPlanDate.toIso8601String(),
    "followup_actual_date": followupActualDate,
    "followup_next_day": followupNextDay == null ? null : followupNextDay,
    "prospect_classification_id": prospectClassificationId,
    "prospect_followup_method_id": prospectFollowupMethodId,
    "prospect_remarks": prospectRemarks,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "updated_user": updatedUser,
    "updated_date": updatedDate,
    "prospect_classification_name": prospectClassificationName,
    "followup_method_name": followupMethodName,
  };
}

class Model {
  int prospectModelId;
  int prospectId;
  String itemCode;
  String itemModel;
  dynamic itemYear;
  String itemType;
  dynamic itemColour;
  int lineNum;
  dynamic kodeKaroseri;
  int quantity;
  int openQty;
  dynamic price;
  String status;
  dynamic canceled;
  int createdUser;
  DateTime createdDate;
  dynamic updatedUser;
  dynamic updatedDate;
  dynamic itemCodeColour;
  dynamic namaKaroseri;

  Model({
    this.prospectModelId,
    this.prospectId,
    this.itemCode,
    this.itemModel,
    this.itemYear,
    this.itemType,
    this.itemColour,
    this.lineNum,
    this.kodeKaroseri,
    this.quantity,
    this.openQty,
    this.price,
    this.status,
    this.canceled,
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
    this.itemCodeColour,
    this.namaKaroseri,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    prospectModelId: json["prospect_model_id"] == null ? null : json["prospect_model_id"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    itemCode: json["item_code"] == null ? null : json["item_code"],
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemYear: json["item_year"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    itemColour: json["item_colour"],
    lineNum: json["line_num"] == null ? null : json["line_num"],
    kodeKaroseri: json["kode_karoseri"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    openQty: json["open_qty"] == null ? null : json["open_qty"],
    price: json["price"],
    status: json["status"] == null ? null : json["status"],
    canceled: json["canceled"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    updatedUser: json["updated_user"],
    updatedDate: json["updated_date"],
    itemCodeColour: json["item_code_colour"],
    namaKaroseri: json["nama_karoseri"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_model_id": prospectModelId == null ? null : prospectModelId,
    "prospect_id": prospectId == null ? null : prospectId,
    "item_code": itemCode == null ? null : itemCode,
    "item_model": itemModel == null ? null : itemModel,
    "item_year": itemYear,
    "item_type": itemType == null ? null : itemType,
    "item_colour": itemColour,
    "line_num": lineNum == null ? null : lineNum,
    "kode_karoseri": kodeKaroseri,
    "quantity": quantity == null ? null : quantity,
    "open_qty": openQty == null ? null : openQty,
    "price": price,
    "status": status == null ? null : status,
    "canceled": canceled,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "updated_user": updatedUser,
    "updated_date": updatedDate,
    "item_code_colour": itemCodeColour,
    "nama_karoseri": namaKaroseri,
  };
}
