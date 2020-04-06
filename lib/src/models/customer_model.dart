// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  CustomerModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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
  String cardCode;
  String cardName;
  String cardType;
  int groupCode;
  int customerGroupId;
  int salesCode;
  dynamic officeBranchCode;
  String officeCode;
  dynamic pricelistCode;
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
  dynamic alamatKtp;
  dynamic occupation;
  String location;
  String pengeluaran;
  String penghasilan;
  String pendidikan;
  String pekerjaan;
  String ecvatgroup;
  String kodeFakturPajak;
  int groupNum;
  String companyName;
  String frozenfor;
  String validfor;
  List<Vin> vins;

  Datum({
    this.cardCode,
    this.cardName,
    this.cardType,
    this.groupCode,
    this.customerGroupId,
    this.salesCode,
    this.officeBranchCode,
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
    this.alamatKtp,
    this.occupation,
    this.location,
    this.pengeluaran,
    this.penghasilan,
    this.pendidikan,
    this.pekerjaan,
    this.ecvatgroup,
    this.kodeFakturPajak,
    this.groupNum,
    this.companyName,
    this.frozenfor,
    this.validfor,
    this.vins,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cardCode: json["card_code"] == null ? null : json["card_code"],
    cardName: json["card_name"] == null ? null : json["card_name"],
    cardType: json["card_type"] == null ? null : json["card_type"],
    groupCode: json["group_code"] == null ? null : json["group_code"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    salesCode: json["sales_code"] == null ? null : json["sales_code"],
    officeBranchCode: json["office_branch_code"],
    officeCode: json["office_code"] == null ? null : json["office_code"],
    pricelistCode: json["pricelist_code"],
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
    alamatKtp: json["alamat_ktp"],
    occupation: json["occupation"],
    location: json["location"] == null ? null : json["location"],
    pengeluaran: json["pengeluaran"] == null ? null : json["pengeluaran"],
    penghasilan: json["penghasilan"] == null ? null : json["penghasilan"],
    pendidikan: json["pendidikan"] == null ? null : json["pendidikan"],
    pekerjaan: json["pekerjaan"] == null ? null : json["pekerjaan"],
    ecvatgroup: json["ecvatgroup"] == null ? null : json["ecvatgroup"],
    kodeFakturPajak: json["kode_faktur_pajak"] == null ? null : json["kode_faktur_pajak"],
    groupNum: json["group_num"] == null ? null : json["group_num"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    frozenfor: json["frozenfor"] == null ? null : json["frozenfor"],
    validfor: json["validfor"] == null ? null : json["validfor"],
    vins: json["vins"] == null ? null : List<Vin>.from(json["vins"].map((x) => Vin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "card_code": cardCode == null ? null : cardCode,
    "card_name": cardName == null ? null : cardName,
    "card_type": cardType == null ? null : cardType,
    "group_code": groupCode == null ? null : groupCode,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "sales_code": salesCode == null ? null : salesCode,
    "office_branch_code": officeBranchCode,
    "office_code": officeCode == null ? null : officeCode,
    "pricelist_code": pricelistCode,
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
    "alamat_ktp": alamatKtp,
    "occupation": occupation,
    "location": location == null ? null : location,
    "pengeluaran": pengeluaran == null ? null : pengeluaran,
    "penghasilan": penghasilan == null ? null : penghasilan,
    "pendidikan": pendidikan == null ? null : pendidikan,
    "pekerjaan": pekerjaan == null ? null : pekerjaan,
    "ecvatgroup": ecvatgroup == null ? null : ecvatgroup,
    "kode_faktur_pajak": kodeFakturPajak == null ? null : kodeFakturPajak,
    "group_num": groupNum == null ? null : groupNum,
    "company_name": companyName == null ? null : companyName,
    "frozenfor": frozenfor == null ? null : frozenfor,
    "validfor": validfor == null ? null : validfor,
    "vins": vins == null ? null : List<dynamic>.from(vins.map((x) => x.toJson())),
  };
}

class Vin {
  String itemCode;
  String itemName;
  String nomorRangka;
  String nomorMesin;
  String whsCode;
  int quantity;
  String nomorRegister;
  String nomorKunci;
  dynamic nomorRrn;
  dynamic kodeTahun;
  dynamic tahun;
  dynamic kodeWarna;
  dynamic namaWarna;
  String officeCode;
  dynamic whsName;
  String officeName;

  Vin({
    this.itemCode,
    this.itemName,
    this.nomorRangka,
    this.nomorMesin,
    this.whsCode,
    this.quantity,
    this.nomorRegister,
    this.nomorKunci,
    this.nomorRrn,
    this.kodeTahun,
    this.tahun,
    this.kodeWarna,
    this.namaWarna,
    this.officeCode,
    this.whsName,
    this.officeName,
  });

  factory Vin.fromJson(Map<String, dynamic> json) => Vin(
    itemCode: json["item_code"] == null ? null : json["item_code"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    nomorRangka: json["nomor_rangka"] == null ? null : json["nomor_rangka"],
    nomorMesin: json["nomor_mesin"] == null ? null : json["nomor_mesin"],
    whsCode: json["whs_code"] == null ? null : json["whs_code"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    nomorRegister: json["nomor_register"] == null ? null : json["nomor_register"],
    nomorKunci: json["nomor_kunci"] == null ? null : json["nomor_kunci"],
    nomorRrn: json["nomor_rrn"],
    kodeTahun: json["kode_tahun"],
    tahun: json["tahun"],
    kodeWarna: json["kode_warna"],
    namaWarna: json["nama_warna"],
    officeCode: json["office_code"] == null ? null : json["office_code"],
    whsName: json["whs_name"],
    officeName: json["office_name"] == null ? null : json["office_name"],
  );

  Map<String, dynamic> toJson() => {
    "item_code": itemCode == null ? null : itemCode,
    "item_name": itemName == null ? null : itemName,
    "nomor_rangka": nomorRangka == null ? null : nomorRangka,
    "nomor_mesin": nomorMesin == null ? null : nomorMesin,
    "whs_code": whsCode == null ? null : whsCode,
    "quantity": quantity == null ? null : quantity,
    "nomor_register": nomorRegister == null ? null : nomorRegister,
    "nomor_kunci": nomorKunci == null ? null : nomorKunci,
    "nomor_rrn": nomorRrn,
    "kode_tahun": kodeTahun,
    "tahun": tahun,
    "kode_warna": kodeWarna,
    "nama_warna": namaWarna,
    "office_code": officeCode == null ? null : officeCode,
    "whs_name": whsName,
    "office_name": officeName == null ? null : officeName,
  };
}
