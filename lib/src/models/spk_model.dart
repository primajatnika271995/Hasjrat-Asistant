// To parse this JSON data, do
//
//     final spkModel = spkModelFromJson(jsonString);

import 'dart:convert';

SpkModel spkModelFromJson(String str) => SpkModel.fromJson(json.decode(str));

String spkModelToJson(SpkModel data) => json.encode(data.toJson());

class SpkModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  SpkModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory SpkModel.fromJson(Map<String, dynamic> json) => SpkModel(
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
  int spkId;
  String spkNum;
  dynamic revisionNum;
  String spkBlanko;
  int prospectId;
  int prospectModelId;
  int itemGroup;
  String spkStatus;
  String canceled;
  dynamic canceledDate;
  dynamic canceledUser;
  dynamic cancelcategoryId;
  dynamic canceledRemarks;
  dynamic canceledTransferbalance;
  dynamic spkMatchStatus;
  dynamic spkMatchingId;
  DateTime spkDate;
  DateTime decDate;
  String cardCode;
  String cardName;
  String cardType;
  int customerGroupId;
  dynamic poCustNum;
  int salesCode;
  String namaUser;
  String telpUser;
  dynamic remarksSpk;
  int paymentTypeId;
  String tradeIn;
  String isFleet;
  dynamic isSgu;
  dynamic sguNum;
  String spkPriceType;
  dynamic spkPrice;
  dynamic plPrice;
  dynamic extraBbnPrice;
  dynamic discAmount;
  dynamic bonusAccAmount;
  String bonusAccDesc;
  dynamic discountDp;
  dynamic discountDpDealer;
  dynamic discountDpSkdealer;
  dynamic discountDpSkdealerDate;
  dynamic discountDpLeasing;
  dynamic discountDpSkleasing;
  dynamic discountDpSkleasingDate;
  dynamic totalDiscAmount;
  dynamic totalBudgetDiscAmount;
  dynamic skhoBudget;
  dynamic skhoAmount;
  dynamic isUhk;
  dynamic uhkAmount;
  dynamic transportFee;
  String isDalamkota;
  dynamic cashInsurance;
  dynamic cashInsuranceAmount;
  dynamic cashInsuranceVendor;
  dynamic docTotal;
  dynamic remarksApproval;
  String officeAreaCode;
  String officeBranchCode;
  String officeCode;
  dynamic sboArdpDocEntry;
  dynamic sboJedpDocEntry;
  dynamic sboJedpLeasingDocEntry;
  dynamic trflag;
  dynamic cancelTrFlag;
  dynamic sboArdpcnDocEntry;
  dynamic sboJedpcnDocEntry;
  dynamic ifRemarks;
  dynamic isConfirmed;
  int createdUser;
  DateTime createdDate;
  dynamic updatedUser;
  dynamic updatedDate;
  dynamic fleetType;
  int customerCriteria;
  dynamic penandatanganSv;
  dynamic newDecDate;
  dynamic updatedDecDate;
  dynamic updatedDecUser;
  String sourceData;
  String customerGroupName;
  String paymentTypeName;
  String salesName;
  String officeName;
  List<Model> models;
  Credits credits;
  Afi afi;

  Datum({
    this.spkId,
    this.spkNum,
    this.revisionNum,
    this.spkBlanko,
    this.prospectId,
    this.prospectModelId,
    this.itemGroup,
    this.spkStatus,
    this.canceled,
    this.canceledDate,
    this.canceledUser,
    this.cancelcategoryId,
    this.canceledRemarks,
    this.canceledTransferbalance,
    this.spkMatchStatus,
    this.spkMatchingId,
    this.spkDate,
    this.decDate,
    this.cardCode,
    this.cardName,
    this.cardType,
    this.customerGroupId,
    this.poCustNum,
    this.salesCode,
    this.namaUser,
    this.telpUser,
    this.remarksSpk,
    this.paymentTypeId,
    this.tradeIn,
    this.isFleet,
    this.isSgu,
    this.sguNum,
    this.spkPriceType,
    this.spkPrice,
    this.plPrice,
    this.extraBbnPrice,
    this.discAmount,
    this.bonusAccAmount,
    this.bonusAccDesc,
    this.discountDp,
    this.discountDpDealer,
    this.discountDpSkdealer,
    this.discountDpSkdealerDate,
    this.discountDpLeasing,
    this.discountDpSkleasing,
    this.discountDpSkleasingDate,
    this.totalDiscAmount,
    this.totalBudgetDiscAmount,
    this.skhoBudget,
    this.skhoAmount,
    this.isUhk,
    this.uhkAmount,
    this.transportFee,
    this.isDalamkota,
    this.cashInsurance,
    this.cashInsuranceAmount,
    this.cashInsuranceVendor,
    this.docTotal,
    this.remarksApproval,
    this.officeAreaCode,
    this.officeBranchCode,
    this.officeCode,
    this.sboArdpDocEntry,
    this.sboJedpDocEntry,
    this.sboJedpLeasingDocEntry,
    this.trflag,
    this.cancelTrFlag,
    this.sboArdpcnDocEntry,
    this.sboJedpcnDocEntry,
    this.ifRemarks,
    this.isConfirmed,
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
    this.fleetType,
    this.customerCriteria,
    this.penandatanganSv,
    this.newDecDate,
    this.updatedDecDate,
    this.updatedDecUser,
    this.sourceData,
    this.customerGroupName,
    this.paymentTypeName,
    this.salesName,
    this.officeName,
    this.models,
    this.credits,
    this.afi,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    spkId: json["spk_id"] == null ? null : json["spk_id"],
    spkNum: json["spk_num"] == null ? null : json["spk_num"],
    revisionNum: json["revision_num"],
    spkBlanko: json["spk_blanko"] == null ? null : json["spk_blanko"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    prospectModelId: json["prospect_model_id"] == null ? null : json["prospect_model_id"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    spkStatus: json["spk_status"] == null ? null : json["spk_status"],
    canceled: json["canceled"] == null ? null : json["canceled"],
    canceledDate: json["canceled_date"],
    canceledUser: json["canceled_user"],
    cancelcategoryId: json["cancelcategory_id"],
    canceledRemarks: json["canceled_remarks"],
    canceledTransferbalance: json["canceled_transferbalance"],
    spkMatchStatus: json["spk_match_status"],
    spkMatchingId: json["spk_matching_id"],
    spkDate: json["spk_date"] == null ? null : DateTime.parse(json["spk_date"]),
    decDate: json["dec_date"] == null ? null : DateTime.parse(json["dec_date"]),
    cardCode: json["card_code"] == null ? null : json["card_code"],
    cardName: json["card_name"] == null ? null : json["card_name"],
    cardType: json["card_type"] == null ? null : json["card_type"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    poCustNum: json["po_cust_num"],
    salesCode: json["sales_code"] == null ? null : json["sales_code"],
    namaUser: json["nama_user"] == null ? null : json["nama_user"],
    telpUser: json["telp_user"] == null ? null : json["telp_user"],
    remarksSpk: json["remarks_spk"],
    paymentTypeId: json["payment_type_id"] == null ? null : json["payment_type_id"],
    tradeIn: json["trade_in"] == null ? null : json["trade_in"],
    isFleet: json["is_fleet"] == null ? null : json["is_fleet"],
    isSgu: json["is_sgu"],
    sguNum: json["sgu_num"],
    spkPriceType: json["spk_price_type"] == null ? null : json["spk_price_type"],
    spkPrice: json["spk_price"] == null ? null : json["spk_price"],
    plPrice: json["pl_price"] == null ? null : json["pl_price"],
    extraBbnPrice: json["extra_bbn_price"] == null ? null : json["extra_bbn_price"],
    discAmount: json["disc_amount"] == null ? null : json["disc_amount"],
    bonusAccAmount: json["bonus_acc_amount"] == null ? null : json["bonus_acc_amount"],
    bonusAccDesc: json["bonus_acc_desc"] == null ? null : json["bonus_acc_desc"],
    discountDp: json["discount_dp"] == null ? null : json["discount_dp"],
    discountDpDealer: json["discount_dp_dealer"],
    discountDpSkdealer: json["discount_dp_skdealer"],
    discountDpSkdealerDate: json["discount_dp_skdealer_date"],
    discountDpLeasing: json["discount_dp_leasing"],
    discountDpSkleasing: json["discount_dp_skleasing"],
    discountDpSkleasingDate: json["discount_dp_skleasing_date"],
    totalDiscAmount: json["total_disc_amount"] == null ? null : json["total_disc_amount"],
    totalBudgetDiscAmount: json["total_budget_disc_amount"],
    skhoBudget: json["skho_budget"],
    skhoAmount: json["skho_amount"],
    isUhk: json["is_uhk"],
    uhkAmount: json["uhk_amount"],
    transportFee: json["transport_fee"],
    isDalamkota: json["is_dalamkota"] == null ? null : json["is_dalamkota"],
    cashInsurance: json["cash_insurance"],
    cashInsuranceAmount: json["cash_insurance_amount"],
    cashInsuranceVendor: json["cash_insurance_vendor"],
    docTotal: json["doc_total"] == null ? null : json["doc_total"],
    remarksApproval: json["remarks_approval"],
    officeAreaCode: json["office_area_code"] == null ? null : json["office_area_code"],
    officeBranchCode: json["office_branch_code"] == null ? null : json["office_branch_code"],
    officeCode: json["office_code"] == null ? null : json["office_code"],
    sboArdpDocEntry: json["SBO_ARDP_DocEntry"],
    sboJedpDocEntry: json["SBO_JEDP_DocEntry"],
    sboJedpLeasingDocEntry: json["SBO_JEDPLeasing_DocEntry"],
    trflag: json["trflag"],
    cancelTrFlag: json["cancelTrFlag"],
    sboArdpcnDocEntry: json["SBO_ARDPCN_DocEntry"],
    sboJedpcnDocEntry: json["SBO_JEDPCN_DocEntry"],
    ifRemarks: json["if_remarks"],
    isConfirmed: json["is_confirmed"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    updatedUser: json["updated_user"],
    updatedDate: json["updated_date"],
    fleetType: json["fleet_type"],
    customerCriteria: json["customer_criteria"] == null ? null : json["customer_criteria"],
    penandatanganSv: json["penandatangan_sv"],
    newDecDate: json["new_dec_date"],
    updatedDecDate: json["updated_dec_date"],
    updatedDecUser: json["updated_dec_user"],
    sourceData: json["source_data"] == null ? null : json["source_data"],
    customerGroupName: json["customer_group_name"] == null ? null : json["customer_group_name"],
    paymentTypeName: json["payment_type_name"] == null ? null : json["payment_type_name"],
    salesName: json["sales_name"] == null ? null : json["sales_name"],
    officeName: json["office_name"] == null ? null : json["office_name"],
    models: json["models"] == null ? null : List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
    credits: json["credits"] == null ? null : Credits.fromJson(json["credits"]),
    afi: json["afi"] == null ? null : Afi.fromJson(json["afi"]),
  );

  Map<String, dynamic> toJson() => {
    "spk_id": spkId == null ? null : spkId,
    "spk_num": spkNum == null ? null : spkNum,
    "revision_num": revisionNum,
    "spk_blanko": spkBlanko == null ? null : spkBlanko,
    "prospect_id": prospectId == null ? null : prospectId,
    "prospect_model_id": prospectModelId == null ? null : prospectModelId,
    "item_group": itemGroup == null ? null : itemGroup,
    "spk_status": spkStatus == null ? null : spkStatus,
    "canceled": canceled == null ? null : canceled,
    "canceled_date": canceledDate,
    "canceled_user": canceledUser,
    "cancelcategory_id": cancelcategoryId,
    "canceled_remarks": canceledRemarks,
    "canceled_transferbalance": canceledTransferbalance,
    "spk_match_status": spkMatchStatus,
    "spk_matching_id": spkMatchingId,
    "spk_date": spkDate == null ? null : spkDate.toIso8601String(),
    "dec_date": decDate == null ? null : decDate.toIso8601String(),
    "card_code": cardCode == null ? null : cardCode,
    "card_name": cardName == null ? null : cardName,
    "card_type": cardType == null ? null : cardType,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "po_cust_num": poCustNum,
    "sales_code": salesCode == null ? null : salesCode,
    "nama_user": namaUser == null ? null : namaUser,
    "telp_user": telpUser == null ? null : telpUser,
    "remarks_spk": remarksSpk,
    "payment_type_id": paymentTypeId == null ? null : paymentTypeId,
    "trade_in": tradeIn == null ? null : tradeIn,
    "is_fleet": isFleet == null ? null : isFleet,
    "is_sgu": isSgu,
    "sgu_num": sguNum,
    "spk_price_type": spkPriceType == null ? null : spkPriceType,
    "spk_price": spkPrice == null ? null : spkPrice,
    "pl_price": plPrice == null ? null : plPrice,
    "extra_bbn_price": extraBbnPrice == null ? null : extraBbnPrice,
    "disc_amount": discAmount == null ? null : discAmount,
    "bonus_acc_amount": bonusAccAmount == null ? null : bonusAccAmount,
    "bonus_acc_desc": bonusAccDesc == null ? null : bonusAccDesc,
    "discount_dp": discountDp == null ? null : discountDp,
    "discount_dp_dealer": discountDpDealer,
    "discount_dp_skdealer": discountDpSkdealer,
    "discount_dp_skdealer_date": discountDpSkdealerDate,
    "discount_dp_leasing": discountDpLeasing,
    "discount_dp_skleasing": discountDpSkleasing,
    "discount_dp_skleasing_date": discountDpSkleasingDate,
    "total_disc_amount": totalDiscAmount == null ? null : totalDiscAmount,
    "total_budget_disc_amount": totalBudgetDiscAmount,
    "skho_budget": skhoBudget,
    "skho_amount": skhoAmount,
    "is_uhk": isUhk,
    "uhk_amount": uhkAmount,
    "transport_fee": transportFee,
    "is_dalamkota": isDalamkota == null ? null : isDalamkota,
    "cash_insurance": cashInsurance,
    "cash_insurance_amount": cashInsuranceAmount,
    "cash_insurance_vendor": cashInsuranceVendor,
    "doc_total": docTotal == null ? null : docTotal,
    "remarks_approval": remarksApproval,
    "office_area_code": officeAreaCode == null ? null : officeAreaCode,
    "office_branch_code": officeBranchCode == null ? null : officeBranchCode,
    "office_code": officeCode == null ? null : officeCode,
    "SBO_ARDP_DocEntry": sboArdpDocEntry,
    "SBO_JEDP_DocEntry": sboJedpDocEntry,
    "SBO_JEDPLeasing_DocEntry": sboJedpLeasingDocEntry,
    "trflag": trflag,
    "cancelTrFlag": cancelTrFlag,
    "SBO_ARDPCN_DocEntry": sboArdpcnDocEntry,
    "SBO_JEDPCN_DocEntry": sboJedpcnDocEntry,
    "if_remarks": ifRemarks,
    "is_confirmed": isConfirmed,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "updated_user": updatedUser,
    "updated_date": updatedDate,
    "fleet_type": fleetType,
    "customer_criteria": customerCriteria == null ? null : customerCriteria,
    "penandatangan_sv": penandatanganSv,
    "new_dec_date": newDecDate,
    "updated_dec_date": updatedDecDate,
    "updated_dec_user": updatedDecUser,
    "source_data": sourceData == null ? null : sourceData,
    "customer_group_name": customerGroupName == null ? null : customerGroupName,
    "payment_type_name": paymentTypeName == null ? null : paymentTypeName,
    "sales_name": salesName == null ? null : salesName,
    "office_name": officeName == null ? null : officeName,
    "models": models == null ? null : List<dynamic>.from(models.map((x) => x.toJson())),
    "credits": credits == null ? null : credits.toJson(),
    "afi": afi == null ? null : afi.toJson(),
  };
}

class Afi {
  int spkAfiId;
  int spkId;
  String nomorKtp;
  String nama1;
  dynamic nama2;
  dynamic nama3;
  String address1;
  String address2;
  String address3;
  String provinsiName;
  String provinsiCode;
  String kabupatenName;
  String kecamatanName;
  String zipcode;
  int platId;
  dynamic isStck;
  DateTime fakturTamDate;
  dynamic platName;

  Afi({
    this.spkAfiId,
    this.spkId,
    this.nomorKtp,
    this.nama1,
    this.nama2,
    this.nama3,
    this.address1,
    this.address2,
    this.address3,
    this.provinsiName,
    this.provinsiCode,
    this.kabupatenName,
    this.kecamatanName,
    this.zipcode,
    this.platId,
    this.isStck,
    this.fakturTamDate,
    this.platName,
  });

  factory Afi.fromJson(Map<String, dynamic> json) => Afi(
    spkAfiId: json["spk_afi_id"] == null ? null : json["spk_afi_id"],
    spkId: json["spk_id"] == null ? null : json["spk_id"],
    nomorKtp: json["nomor_ktp"] == null ? null : json["nomor_ktp"],
    nama1: json["nama1"] == null ? null : json["nama1"],
    nama2: json["nama2"],
    nama3: json["nama3"],
    address1: json["address1"] == null ? null : json["address1"],
    address2: json["address2"] == null ? null : json["address2"],
    address3: json["address3"] == null ? null : json["address3"],
    provinsiName: json["provinsi_name"] == null ? null : json["provinsi_name"],
    provinsiCode: json["provinsi_code"] == null ? null : json["provinsi_code"],
    kabupatenName: json["kabupaten_name"] == null ? null : json["kabupaten_name"],
    kecamatanName: json["kecamatan_name"] == null ? null : json["kecamatan_name"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    platId: json["plat_id"] == null ? null : json["plat_id"],
    isStck: json["is_stck"],
    fakturTamDate: json["faktur_tam_date"] == null ? null : DateTime.parse(json["faktur_tam_date"]),
    platName: json["plat_name"],
  );

  Map<String, dynamic> toJson() => {
    "spk_afi_id": spkAfiId == null ? null : spkAfiId,
    "spk_id": spkId == null ? null : spkId,
    "nomor_ktp": nomorKtp == null ? null : nomorKtp,
    "nama1": nama1 == null ? null : nama1,
    "nama2": nama2,
    "nama3": nama3,
    "address1": address1 == null ? null : address1,
    "address2": address2 == null ? null : address2,
    "address3": address3 == null ? null : address3,
    "provinsi_name": provinsiName == null ? null : provinsiName,
    "provinsi_code": provinsiCode == null ? null : provinsiCode,
    "kabupaten_name": kabupatenName == null ? null : kabupatenName,
    "kecamatan_name": kecamatanName == null ? null : kecamatanName,
    "zipcode": zipcode == null ? null : zipcode,
    "plat_id": platId == null ? null : platId,
    "is_stck": isStck,
    "faktur_tam_date": fakturTamDate == null ? null : fakturTamDate.toIso8601String(),
    "plat_name": platName,
  };
}

class Credits {
  int spkCreditId;
  int spkId;
  int leasingId;
  int tenor;
  String insuranceType;
  dynamic insuranceAmountNonHmf;
  dynamic poNum;
  dynamic poDate;
  dynamic dpAmount;
  dynamic angsuran;
  String namaAsuransi;
  dynamic covernote;
  dynamic covernoteDate;
  dynamic subsidiDealerAmount;
  dynamic firstInstallment;
  dynamic firstInstallmentType;
  dynamic insuranceAmount;
  dynamic insuranceAmountType;
  dynamic admAmount;
  dynamic admAmountType;
  dynamic createdUser;
  dynamic createdDate;
  dynamic updatedUser;
  dynamic updatedDate;
  dynamic penandatanganSv;
  String leasingName;

  Credits({
    this.spkCreditId,
    this.spkId,
    this.leasingId,
    this.tenor,
    this.insuranceType,
    this.insuranceAmountNonHmf,
    this.poNum,
    this.poDate,
    this.dpAmount,
    this.angsuran,
    this.namaAsuransi,
    this.covernote,
    this.covernoteDate,
    this.subsidiDealerAmount,
    this.firstInstallment,
    this.firstInstallmentType,
    this.insuranceAmount,
    this.insuranceAmountType,
    this.admAmount,
    this.admAmountType,
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
    this.penandatanganSv,
    this.leasingName,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
    spkCreditId: json["spk_credit_id"] == null ? null : json["spk_credit_id"],
    spkId: json["spk_id"] == null ? null : json["spk_id"],
    leasingId: json["leasing_id"] == null ? null : json["leasing_id"],
    tenor: json["tenor"] == null ? null : json["tenor"],
    insuranceType: json["insurance_type"] == null ? null : json["insurance_type"],
    insuranceAmountNonHmf: json["insurance_amount_non_hmf"] == null ? null : json["insurance_amount_non_hmf"],
    poNum: json["po_num"],
    poDate: json["po_date"],
    dpAmount: json["dp_amount"] == null ? null : json["dp_amount"],
    angsuran: json["angsuran"] == null ? null : json["angsuran"],
    namaAsuransi: json["nama_asuransi"] == null ? null : json["nama_asuransi"],
    covernote: json["covernote"],
    covernoteDate: json["covernote_date"],
    subsidiDealerAmount: json["subsidi_dealer_amount"],
    firstInstallment: json["first_installment"],
    firstInstallmentType: json["first_installment_type"],
    insuranceAmount: json["insurance_amount"],
    insuranceAmountType: json["insurance_amount_type"],
    admAmount: json["adm_amount"],
    admAmountType: json["adm_amount_type"],
    createdUser: json["created_user"],
    createdDate: json["created_date"],
    updatedUser: json["updated_user"],
    updatedDate: json["updated_date"],
    penandatanganSv: json["penandatangan_sv"],
    leasingName: json["leasing_name"] == null ? null : json["leasing_name"],
  );

  Map<String, dynamic> toJson() => {
    "spk_credit_id": spkCreditId == null ? null : spkCreditId,
    "spk_id": spkId == null ? null : spkId,
    "leasing_id": leasingId == null ? null : leasingId,
    "tenor": tenor == null ? null : tenor,
    "insurance_type": insuranceType == null ? null : insuranceType,
    "insurance_amount_non_hmf": insuranceAmountNonHmf == null ? null : insuranceAmountNonHmf,
    "po_num": poNum,
    "po_date": poDate,
    "dp_amount": dpAmount == null ? null : dpAmount,
    "angsuran": angsuran == null ? null : angsuran,
    "nama_asuransi": namaAsuransi == null ? null : namaAsuransi,
    "covernote": covernote,
    "covernote_date": covernoteDate,
    "subsidi_dealer_amount": subsidiDealerAmount,
    "first_installment": firstInstallment,
    "first_installment_type": firstInstallmentType,
    "insurance_amount": insuranceAmount,
    "insurance_amount_type": insuranceAmountType,
    "adm_amount": admAmount,
    "adm_amount_type": admAmountType,
    "created_user": createdUser,
    "created_date": createdDate,
    "updated_user": updatedUser,
    "updated_date": updatedDate,
    "penandatangan_sv": penandatanganSv,
    "leasing_name": leasingName == null ? null : leasingName,
  };
}

class Model {
  int spkModelId;
  int spkId;
  int prospectModelId;
  int prospectLineNum;
  String itemCode;
  String itemModel;
  String itemYear;
  String itemType;
  String itemColour;
  dynamic whsCode;
  dynamic modelKaroseri;
  dynamic nomorRangka;
  dynamic nomorMesin;
  dynamic nomorRegister;
  dynamic nomorKunci;
  dynamic lineNum;
  int quantity;
  dynamic price;
  dynamic plOntr;
  dynamic plOfftr;
  dynamic plBbn;
  dynamic plLogistic;
  dynamic status;
  dynamic isPdi;
  dynamic pdiNum;
  dynamic pdiUser;
  dynamic pdiDatetime;
  dynamic createdUser;
  dynamic createdDate;
  dynamic updatedUser;
  dynamic updatedDate;
  dynamic itemCodeColour;
  dynamic prospectSourceId;

  Model({
    this.spkModelId,
    this.spkId,
    this.prospectModelId,
    this.prospectLineNum,
    this.itemCode,
    this.itemModel,
    this.itemYear,
    this.itemType,
    this.itemColour,
    this.whsCode,
    this.modelKaroseri,
    this.nomorRangka,
    this.nomorMesin,
    this.nomorRegister,
    this.nomorKunci,
    this.lineNum,
    this.quantity,
    this.price,
    this.plOntr,
    this.plOfftr,
    this.plBbn,
    this.plLogistic,
    this.status,
    this.isPdi,
    this.pdiNum,
    this.pdiUser,
    this.pdiDatetime,
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
    this.itemCodeColour,
    this.prospectSourceId,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    spkModelId: json["spk_model_id"] == null ? null : json["spk_model_id"],
    spkId: json["spk_id"] == null ? null : json["spk_id"],
    prospectModelId: json["prospect_model_id"] == null ? null : json["prospect_model_id"],
    prospectLineNum: json["prospect_line_num"] == null ? null : json["prospect_line_num"],
    itemCode: json["item_code"] == null ? null : json["item_code"],
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemYear: json["item_year"] == null ? null : json["item_year"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    itemColour: json["item_colour"] == null ? null : json["item_colour"],
    whsCode: json["whs_code"],
    modelKaroseri: json["model_karoseri"],
    nomorRangka: json["nomor_rangka"],
    nomorMesin: json["nomor_mesin"],
    nomorRegister: json["nomor_register"],
    nomorKunci: json["nomor_kunci"],
    lineNum: json["line_num"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    plOntr: json["pl_ontr"] == null ? null : json["pl_ontr"],
    plOfftr: json["pl_offtr"] == null ? null : json["pl_offtr"],
    plBbn: json["pl_bbn"] == null ? null : json["pl_bbn"],
    plLogistic: json["pl_logistic"] == null ? null : json["pl_logistic"],
    status: json["status"],
    isPdi: json["is_pdi"],
    pdiNum: json["pdi_num"],
    pdiUser: json["pdi_user"],
    pdiDatetime: json["pdi_datetime"],
    createdUser: json["created_user"],
    createdDate: json["created_date"],
    updatedUser: json["updated_user"],
    updatedDate: json["updated_date"],
    itemCodeColour: json["item_code_colour"],
    prospectSourceId: json["prospect_source_id"],
  );

  Map<String, dynamic> toJson() => {
    "spk_model_id": spkModelId == null ? null : spkModelId,
    "spk_id": spkId == null ? null : spkId,
    "prospect_model_id": prospectModelId == null ? null : prospectModelId,
    "prospect_line_num": prospectLineNum == null ? null : prospectLineNum,
    "item_code": itemCode == null ? null : itemCode,
    "item_model": itemModel == null ? null : itemModel,
    "item_year": itemYear == null ? null : itemYear,
    "item_type": itemType == null ? null : itemType,
    "item_colour": itemColour == null ? null : itemColour,
    "whs_code": whsCode,
    "model_karoseri": modelKaroseri,
    "nomor_rangka": nomorRangka,
    "nomor_mesin": nomorMesin,
    "nomor_register": nomorRegister,
    "nomor_kunci": nomorKunci,
    "line_num": lineNum,
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "pl_ontr": plOntr == null ? null : plOntr,
    "pl_offtr": plOfftr == null ? null : plOfftr,
    "pl_bbn": plBbn == null ? null : plBbn,
    "pl_logistic": plLogistic == null ? null : plLogistic,
    "status": status,
    "is_pdi": isPdi,
    "pdi_num": pdiNum,
    "pdi_user": pdiUser,
    "pdi_datetime": pdiDatetime,
    "created_user": createdUser,
    "created_date": createdDate,
    "updated_user": updatedUser,
    "updated_date": updatedDate,
    "item_code_colour": itemCodeColour,
    "prospect_source_id": prospectSourceId,
  };
}
