// To parse this JSON data, do
//
//     final programPenjualanModel = programPenjualanModelFromJson(jsonString);

import 'dart:convert';

ProgramPenjualanModel programPenjualanModelFromJson(String str) => ProgramPenjualanModel.fromJson(json.decode(str));

String programPenjualanModelToJson(ProgramPenjualanModel data) => json.encode(data.toJson());

class ProgramPenjualanModel {
    String status;
    List<Datum> data;
    String error;
    String message;
    int retCode;
    dynamic token;

    ProgramPenjualanModel({
        this.status,
        this.data,
        this.error,
        this.message,
        this.retCode,
        this.token,
    });

    factory ProgramPenjualanModel.fromJson(Map<String, dynamic> json) => ProgramPenjualanModel(
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
    int programPenjualanId;
    String programPenjualanName;
    String isActive;
    String isMandatory;
    DateTime startDate;
    DateTime endDate;
    int paymentTypeId;
    String leasingCode;
    String accountCashbackHasjrat;
    String accountCashbackLeasing;
    String programPenjualanType;
    String noMou;
    DateTime tglMou;
    String remarks;
    int gracePeriod;
    String isExclusive;
    List<Model> models;
    List<Office> offices;
    List<Leasing> leasings;
    String paymentTypeName;

    Datum({
        this.programPenjualanId,
        this.programPenjualanName,
        this.isActive,
        this.isMandatory,
        this.startDate,
        this.endDate,
        this.paymentTypeId,
        this.leasingCode,
        this.accountCashbackHasjrat,
        this.accountCashbackLeasing,
        this.programPenjualanType,
        this.noMou,
        this.tglMou,
        this.remarks,
        this.gracePeriod,
        this.isExclusive,
        this.models,
        this.offices,
        this.leasings,
        this.paymentTypeName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        programPenjualanId: json["program_penjualan_id"] == null ? null : json["program_penjualan_id"],
        programPenjualanName: json["program_penjualan_name"] == null ? null : json["program_penjualan_name"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isMandatory: json["is_mandatory"] == null ? null : json["is_mandatory"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        paymentTypeId: json["payment_type_id"] == null ? null : json["payment_type_id"],
        leasingCode: json["leasing_code"] == null ? null : json["leasing_code"],
        accountCashbackHasjrat: json["account_cashback_hasjrat"] == null ? null : json["account_cashback_hasjrat"],
        accountCashbackLeasing: json["account_cashback_leasing"] == null ? null : json["account_cashback_leasing"],
        programPenjualanType: json["program_penjualan_type"] == null ? null : json["program_penjualan_type"],
        noMou: json["no_mou"] == null ? null : json["no_mou"],
        tglMou: json["tgl_mou"] == null ? null : DateTime.parse(json["tgl_mou"]),
        remarks: json["remarks"] == null ? null : json["remarks"],
        gracePeriod: json["grace_period"] == null ? null : json["grace_period"],
        isExclusive: json["is_exclusive"] == null ? null : json["is_exclusive"],
        models: json["models"] == null ? null : List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
        offices: json["offices"] == null ? null : List<Office>.from(json["offices"].map((x) => Office.fromJson(x))),
        leasings: json["leasings"] == null ? null : List<Leasing>.from(json["leasings"].map((x) => Leasing.fromJson(x))),
        paymentTypeName: json["payment_type_name"] == null ? null : json["payment_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "program_penjualan_id": programPenjualanId == null ? null : programPenjualanId,
        "program_penjualan_name": programPenjualanName == null ? null : programPenjualanName,
        "is_active": isActive == null ? null : isActive,
        "is_mandatory": isMandatory == null ? null : isMandatory,
        "start_date": startDate == null ? null : startDate.toIso8601String(),
        "end_date": endDate == null ? null : endDate.toIso8601String(),
        "payment_type_id": paymentTypeId == null ? null : paymentTypeId,
        "leasing_code": leasingCode == null ? null : leasingCode,
        "account_cashback_hasjrat": accountCashbackHasjrat == null ? null : accountCashbackHasjrat,
        "account_cashback_leasing": accountCashbackLeasing == null ? null : accountCashbackLeasing,
        "program_penjualan_type": programPenjualanType == null ? null : programPenjualanType,
        "no_mou": noMou == null ? null : noMou,
        "tgl_mou": tglMou == null ? null : tglMou.toIso8601String(),
        "remarks": remarks == null ? null : remarks,
        "grace_period": gracePeriod == null ? null : gracePeriod,
        "is_exclusive": isExclusive == null ? null : isExclusive,
        "models": models == null ? null : List<dynamic>.from(models.map((x) => x.toJson())),
        "offices": offices == null ? null : List<dynamic>.from(offices.map((x) => x.toJson())),
        "leasings": leasings == null ? null : List<dynamic>.from(leasings.map((x) => x.toJson())),
        "payment_type_name": paymentTypeName == null ? null : paymentTypeName,
    };
}

class Leasing {
    int programPenjualanLeasingId;
    int programPenjualanId;
    String leasingCode;
    String accountCashbackLeasing;
    String leasingName;

    Leasing({
        this.programPenjualanLeasingId,
        this.programPenjualanId,
        this.leasingCode,
        this.accountCashbackLeasing,
        this.leasingName,
    });

    factory Leasing.fromJson(Map<String, dynamic> json) => Leasing(
        programPenjualanLeasingId: json["program_penjualan_leasing_id"] == null ? null : json["program_penjualan_leasing_id"],
        programPenjualanId: json["program_penjualan_id"] == null ? null : json["program_penjualan_id"],
        leasingCode: json["leasing_code"] == null ? null : json["leasing_code"],
        accountCashbackLeasing: json["account_cashback_leasing"] == null ? null : json["account_cashback_leasing"],
        leasingName: json["leasing_name"] == null ? null : json["leasing_name"],
    );

    Map<String, dynamic> toJson() => {
        "program_penjualan_leasing_id": programPenjualanLeasingId == null ? null : programPenjualanLeasingId,
        "program_penjualan_id": programPenjualanId == null ? null : programPenjualanId,
        "leasing_code": leasingCode == null ? null : leasingCode,
        "account_cashback_leasing": accountCashbackLeasing == null ? null : accountCashbackLeasing,
        "leasing_name": leasingName == null ? null : leasingName,
    };
}

class Model {
    int programPenjualanModelId;
    int programPenjualanId;
    String itemCode;
    String itemModel;
    String itemYear;
    String itemType;
    dynamic itemColour;
    String nomorRegister;
    String nomorRangka;
    double cashbackHasjrat;
    double cashbackLeasing;
    double discPl;
    dynamic subsidiDealer;
    String gift;
    String itemName;

    Model({
        this.programPenjualanModelId,
        this.programPenjualanId,
        this.itemCode,
        this.itemModel,
        this.itemYear,
        this.itemType,
        this.itemColour,
        this.nomorRegister,
        this.nomorRangka,
        this.cashbackHasjrat,
        this.cashbackLeasing,
        this.discPl,
        this.subsidiDealer,
        this.gift,
        this.itemName,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        programPenjualanModelId: json["program_penjualan_model_id"] == null ? null : json["program_penjualan_model_id"],
        programPenjualanId: json["program_penjualan_id"] == null ? null : json["program_penjualan_id"],
        itemCode: json["item_code"] == null ? null : json["item_code"],
        itemModel: json["item_model"] == null ? null : json["item_model"],
        itemYear: json["item_year"] == null ? null : json["item_year"],
        itemType: json["item_type"] == null ? null : json["item_type"],
        itemColour: json["item_colour"],
        nomorRegister: json["nomor_register"] == null ? null : json["nomor_register"],
        nomorRangka: json["nomor_rangka"] == null ? null : json["nomor_rangka"],
        cashbackHasjrat: json["cashback_hasjrat"] == null ? null : json["cashback_hasjrat"],
        cashbackLeasing: json["cashback_leasing"] == null ? null : json["cashback_leasing"],
        discPl: json["disc_pl"] == null ? null : json["disc_pl"],
        subsidiDealer: json["subsidi_dealer"],
        gift: json["gift"] == null ? null : json["gift"],
        itemName: json["item_name"] == null ? null : json["item_name"],
    );

    Map<String, dynamic> toJson() => {
        "program_penjualan_model_id": programPenjualanModelId == null ? null : programPenjualanModelId,
        "program_penjualan_id": programPenjualanId == null ? null : programPenjualanId,
        "item_code": itemCode == null ? null : itemCode,
        "item_model": itemModel == null ? null : itemModel,
        "item_year": itemYear == null ? null : itemYear,
        "item_type": itemType == null ? null : itemType,
        "item_colour": itemColour,
        "nomor_register": nomorRegister == null ? null : nomorRegister,
        "nomor_rangka": nomorRangka == null ? null : nomorRangka,
        "cashback_hasjrat": cashbackHasjrat == null ? null : cashbackHasjrat,
        "cashback_leasing": cashbackLeasing == null ? null : cashbackLeasing,
        "disc_pl": discPl == null ? null : discPl,
        "subsidi_dealer": subsidiDealer,
        "gift": gift == null ? null : gift,
        "item_name": itemName == null ? null : itemName,
    };
}

class Office {
    int programPenjualanBranchId;
    int programPenjualanId;
    String officeAreaCode;
    String officeBranchCode;
    String officeCode;
    String officeName;

    Office({
        this.programPenjualanBranchId,
        this.programPenjualanId,
        this.officeAreaCode,
        this.officeBranchCode,
        this.officeCode,
        this.officeName,
    });

    factory Office.fromJson(Map<String, dynamic> json) => Office(
        programPenjualanBranchId: json["program_penjualan_branch_id"] == null ? null : json["program_penjualan_branch_id"],
        programPenjualanId: json["program_penjualan_id"] == null ? null : json["program_penjualan_id"],
        officeAreaCode: json["office_area_code"] == null ? null : json["office_area_code"],
        officeBranchCode: json["office_branch_code"] == null ? null : json["office_branch_code"],
        officeCode: json["office_code"] == null ? null : json["office_code"],
        officeName: json["office_name"] == null ? null : json["office_name"],
    );

    Map<String, dynamic> toJson() => {
        "program_penjualan_branch_id": programPenjualanBranchId == null ? null : programPenjualanBranchId,
        "program_penjualan_id": programPenjualanId == null ? null : programPenjualanId,
        "office_area_code": officeAreaCode == null ? null : officeAreaCode,
        "office_branch_code": officeBranchCode == null ? null : officeBranchCode,
        "office_code": officeCode == null ? null : officeCode,
        "office_name": officeName == null ? null : officeName,
    };
}
