// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  Welcome({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
  String leadCode;
  String cardCode;
  String cardName;
  String cardType;
  int groupCode;
  int customerGroupId;
  int salesCode;
  String officeCode;
  String pricelistCode;
  String gender;
  String phone1;
  String phone2;
  String phone3;
  String fax;
  String email;
  DateTime dob;
  String taxId;
  String taxAddress;
  String noKtp;
  dynamic occupation;
  String location;
  String penghasilan;
  String pengeluaran;
  String pendidikan;
  String pekerjaan;
  String ecvatgroup;
  String kodeFakturPajak;
  String companyName;
  DateTime suspectDate;
  dynamic notes;
  String isBdu;
  int createdUser;
  DateTime createdDate;
  dynamic prospectSourceId;
  dynamic suspectFollowup;
  dynamic suspectClassificationId;
  dynamic suspectStatus;
  String sourceData;
  dynamic suspectAutoclosedDate;
  List<Address> addresses;
  String customerGroupName;
  dynamic prospectSourceName;
  dynamic prospectClassificationName;
  String salesName;
  String officeName;
  String penghasilanName;
  String pengeluaranName;
  String pendidikanName;
  String pekerjaanName;
  String locationName;
  String cardtype;
  String suspectstatus;

  Datum({
    this.leadCode,
    this.cardCode,
    this.cardName,
    this.cardType,
    this.groupCode,
    this.customerGroupId,
    this.salesCode,
    this.officeCode,
    this.pricelistCode,
    this.gender,
    this.phone1,
    this.phone2,
    this.phone3,
    this.fax,
    this.email,
    this.dob,
    this.taxId,
    this.taxAddress,
    this.noKtp,
    this.occupation,
    this.location,
    this.penghasilan,
    this.pengeluaran,
    this.pendidikan,
    this.pekerjaan,
    this.ecvatgroup,
    this.kodeFakturPajak,
    this.companyName,
    this.suspectDate,
    this.notes,
    this.isBdu,
    this.createdUser,
    this.createdDate,
    this.prospectSourceId,
    this.suspectFollowup,
    this.suspectClassificationId,
    this.suspectStatus,
    this.sourceData,
    this.suspectAutoclosedDate,
    this.addresses,
    this.customerGroupName,
    this.prospectSourceName,
    this.prospectClassificationName,
    this.salesName,
    this.officeName,
    this.penghasilanName,
    this.pengeluaranName,
    this.pendidikanName,
    this.pekerjaanName,
    this.locationName,
    this.cardtype,
    this.suspectstatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    leadCode: json["lead_code"] == null ? null : json["lead_code"],
    cardCode: json["card_code"] == null ? null : json["card_code"],
    cardName: json["card_name"] == null ? null : json["card_name"],
    cardType: json["card_type"] == null ? null : json["card_type"],
    groupCode: json["group_code"] == null ? null : json["group_code"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    salesCode: json["sales_code"] == null ? null : json["sales_code"],
    officeCode: json["office_code"] == null ? null : json["office_code"],
    pricelistCode: json["pricelist_code"] == null ? null : json["pricelist_code"],
    gender: json["gender"] == null ? null : json["gender"],
    phone1: json["phone1"] == null ? null : json["phone1"],
    phone2: json["phone2"] == null ? null : json["phone2"],
    phone3: json["phone3"] == null ? null : json["phone3"],
    fax: json["fax"] == null ? null : json["fax"],
    email: json["email"] == null ? null : json["email"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    taxId: json["tax_id"] == null ? null : json["tax_id"],
    taxAddress: json["tax_address"] == null ? null : json["tax_address"],
    noKtp: json["no_ktp"] == null ? null : json["no_ktp"],
    occupation: json["occupation"],
    location: json["location"] == null ? null : json["location"],
    penghasilan: json["penghasilan"] == null ? null : json["penghasilan"],
    pengeluaran: json["pengeluaran"] == null ? null : json["pengeluaran"],
    pendidikan: json["pendidikan"] == null ? null : json["pendidikan"],
    pekerjaan: json["pekerjaan"] == null ? null : json["pekerjaan"],
    ecvatgroup: json["ecvatgroup"] == null ? null : json["ecvatgroup"],
    kodeFakturPajak: json["kode_faktur_pajak"] == null ? null : json["kode_faktur_pajak"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    suspectDate: json["suspect_date"] == null ? null : DateTime.parse(json["suspect_date"]),
    notes: json["notes"],
    isBdu: json["isBDU"] == null ? null : json["isBDU"],
    createdUser: json["created_user"] == null ? null : json["created_user"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    prospectSourceId: json["prospect_source_id"],
    suspectFollowup: json["suspect_followup"],
    suspectClassificationId: json["suspect_classification_id"],
    suspectStatus: json["suspect_status"],
    sourceData: json["source_data"] == null ? null : json["source_data"],
    suspectAutoclosedDate: json["suspect_autoclosed_date"],
    addresses: json["addresses"] == null ? null : List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    customerGroupName: json["customer_group_name"] == null ? null : json["customer_group_name"],
    prospectSourceName: json["prospect_source_name"],
    prospectClassificationName: json["prospect_classification_name"],
    salesName: json["sales_name"] == null ? null : json["sales_name"],
    officeName: json["office_name"] == null ? null : json["office_name"],
    penghasilanName: json["penghasilan_name"] == null ? null : json["penghasilan_name"],
    pengeluaranName: json["pengeluaran_name"] == null ? null : json["pengeluaran_name"],
    pendidikanName: json["pendidikan_name"] == null ? null : json["pendidikan_name"],
    pekerjaanName: json["pekerjaan_name"] == null ? null : json["pekerjaan_name"],
    locationName: json["location_name"] == null ? null : json["location_name"],
    cardtype: json["cardtype"] == null ? null : json["cardtype"],
    suspectstatus: json["suspectstatus"] == null ? null : json["suspectstatus"],
  );

  Map<String, dynamic> toJson() => {
    "lead_code": leadCode == null ? null : leadCode,
    "card_code": cardCode == null ? null : cardCode,
    "card_name": cardName == null ? null : cardName,
    "card_type": cardType == null ? null : cardType,
    "group_code": groupCode == null ? null : groupCode,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "sales_code": salesCode == null ? null : salesCode,
    "office_code": officeCode == null ? null : officeCode,
    "pricelist_code": pricelistCode == null ? null : pricelistCode,
    "gender": gender == null ? null : gender,
    "phone1": phone1 == null ? null : phone1,
    "phone2": phone2 == null ? null : phone2,
    "phone3": phone3 == null ? null : phone3,
    "fax": fax == null ? null : fax,
    "email": email == null ? null : email,
    "dob": dob == null ? null : dob.toIso8601String(),
    "tax_id": taxId == null ? null : taxId,
    "tax_address": taxAddress == null ? null : taxAddress,
    "no_ktp": noKtp == null ? null : noKtp,
    "occupation": occupation,
    "location": location == null ? null : location,
    "penghasilan": penghasilan == null ? null : penghasilan,
    "pengeluaran": pengeluaran == null ? null : pengeluaran,
    "pendidikan": pendidikan == null ? null : pendidikan,
    "pekerjaan": pekerjaan == null ? null : pekerjaan,
    "ecvatgroup": ecvatgroup == null ? null : ecvatgroup,
    "kode_faktur_pajak": kodeFakturPajak == null ? null : kodeFakturPajak,
    "company_name": companyName == null ? null : companyName,
    "suspect_date": suspectDate == null ? null : suspectDate.toIso8601String(),
    "notes": notes,
    "isBDU": isBdu == null ? null : isBdu,
    "created_user": createdUser == null ? null : createdUser,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
    "prospect_source_id": prospectSourceId,
    "suspect_followup": suspectFollowup,
    "suspect_classification_id": suspectClassificationId,
    "suspect_status": suspectStatus,
    "source_data": sourceData == null ? null : sourceData,
    "suspect_autoclosed_date": suspectAutoclosedDate,
    "addresses": addresses == null ? null : List<dynamic>.from(addresses.map((x) => x.toJson())),
    "customer_group_name": customerGroupName == null ? null : customerGroupName,
    "prospect_source_name": prospectSourceName,
    "prospect_classification_name": prospectClassificationName,
    "sales_name": salesName == null ? null : salesName,
    "office_name": officeName == null ? null : officeName,
    "penghasilan_name": penghasilanName == null ? null : penghasilanName,
    "pengeluaran_name": pengeluaranName == null ? null : pengeluaranName,
    "pendidikan_name": pendidikanName == null ? null : pendidikanName,
    "pekerjaan_name": pekerjaanName == null ? null : pekerjaanName,
    "location_name": locationName == null ? null : locationName,
    "cardtype": cardtype == null ? null : cardtype,
    "suspectstatus": suspectstatus == null ? null : suspectstatus,
  };
}

class Address {
  String leadCode;
  String cardCode;
  String address1;
  String address2;
  String address3;
  String provinsiCode;
  String kabupatenCode;
  String kecamatanCode;
  String zipcode;
  String provinsiName;
  String kabupatenName;
  String kecamatanName;

  Address({
    this.leadCode,
    this.cardCode,
    this.address1,
    this.address2,
    this.address3,
    this.provinsiCode,
    this.kabupatenCode,
    this.kecamatanCode,
    this.zipcode,
    this.provinsiName,
    this.kabupatenName,
    this.kecamatanName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    leadCode: json["lead_code"] == null ? null : json["lead_code"],
    cardCode: json["card_code"] == null ? null : json["card_code"],
    address1: json["address1"] == null ? null : json["address1"],
    address2: json["address2"] == null ? null : json["address2"],
    address3: json["address3"] == null ? null : json["address3"],
    provinsiCode: json["provinsi_code"] == null ? null : json["provinsi_code"],
    kabupatenCode: json["kabupaten_code"] == null ? null : json["kabupaten_code"],
    kecamatanCode: json["kecamatan_code"] == null ? null : json["kecamatan_code"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    provinsiName: json["provinsi_name"] == null ? null : json["provinsi_name"],
    kabupatenName: json["kabupaten_name"] == null ? null : json["kabupaten_name"],
    kecamatanName: json["kecamatan_name"] == null ? null : json["kecamatan_name"],
  );

  Map<String, dynamic> toJson() => {
    "lead_code": leadCode == null ? null : leadCode,
    "card_code": cardCode == null ? null : cardCode,
    "address1": address1 == null ? null : address1,
    "address2": address2 == null ? null : address2,
    "address3": address3 == null ? null : address3,
    "provinsi_code": provinsiCode == null ? null : provinsiCode,
    "kabupaten_code": kabupatenCode == null ? null : kabupatenCode,
    "kecamatan_code": kecamatanCode == null ? null : kecamatanCode,
    "zipcode": zipcode == null ? null : zipcode,
    "provinsi_name": provinsiName == null ? null : provinsiName,
    "kabupaten_name": kabupatenName == null ? null : kabupatenName,
    "kecamatan_name": kecamatanName == null ? null : kecamatanName,
  };
}
