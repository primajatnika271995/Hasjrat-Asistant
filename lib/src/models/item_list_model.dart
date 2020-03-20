// To parse this JSON data, do
//
//     final itemListModel = itemListModelFromJson(jsonString);

import 'dart:convert';

ItemListModel itemListModelFromJson(String str) => ItemListModel.fromJson(json.decode(str));

String itemListModelToJson(ItemListModel data) => json.encode(data.toJson());

class ItemListModel {
  String status;
  List<Datum> data;
  String error;
  String message;
  int retCode;
  dynamic token;

  ItemListModel({
    this.status,
    this.data,
    this.error,
    this.message,
    this.retCode,
    this.token,
  });

  factory ItemListModel.fromJson(Map<String, dynamic> json) => ItemListModel(
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
  int itemId;
  String itemCode;
  String itemName;
  int itemGroup;
  dynamic itemClass;
  dynamic itemClass1;
  String itemModel;
  String itemType;
  String uom;
  dynamic salesUom;
  dynamic numinsale;
  String vatgroupsa;
  String vatgrouppu;
  dynamic kodeKaroseri;
  String frozenFor;
  dynamic frozenFrom;
  dynamic frozenTo;
  String inventoryItem;
  List<Pricelist> pricelists;
  List<Stock> stocks;

  Datum({
    this.itemId,
    this.itemCode,
    this.itemName,
    this.itemGroup,
    this.itemClass,
    this.itemClass1,
    this.itemModel,
    this.itemType,
    this.uom,
    this.salesUom,
    this.numinsale,
    this.vatgroupsa,
    this.vatgrouppu,
    this.kodeKaroseri,
    this.frozenFor,
    this.frozenFrom,
    this.frozenTo,
    this.inventoryItem,
    this.pricelists,
    this.stocks,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    itemId: json["item_id"] == null ? null : json["item_id"],
    itemCode: json["item_code"] == null ? null : json["item_code"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    itemClass: json["item_class"],
    itemClass1: json["item_class1"],
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    uom: json["uom"] == null ? null : json["uom"],
    salesUom: json["sales_uom"],
    numinsale: json["numinsale"],
    vatgroupsa: json["vatgroupsa"] == null ? null : json["vatgroupsa"],
    vatgrouppu: json["vatgrouppu"] == null ? null : json["vatgrouppu"],
    kodeKaroseri: json["kode_karoseri"],
    frozenFor: json["frozen_for"] == null ? null : json["frozen_for"],
    frozenFrom: json["frozen_from"],
    frozenTo: json["frozen_to"],
    inventoryItem: json["inventory_item"] == null ? null : json["inventory_item"],
    pricelists: json["pricelists"] == null ? null : List<Pricelist>.from(json["pricelists"].map((x) => Pricelist.fromJson(x))),
    stocks: json["stocks"] == null ? null : List<Stock>.from(json["stocks"].map((x) => Stock.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId == null ? null : itemId,
    "item_code": itemCode == null ? null : itemCode,
    "item_name": itemName == null ? null : itemName,
    "item_group": itemGroup == null ? null : itemGroup,
    "item_class": itemClass,
    "item_class1": itemClass1,
    "item_model": itemModel == null ? null : itemModel,
    "item_type": itemType == null ? null : itemType,
    "uom": uom == null ? null : uom,
    "sales_uom": salesUom,
    "numinsale": numinsale,
    "vatgroupsa": vatgroupsa == null ? null : vatgroupsa,
    "vatgrouppu": vatgrouppu == null ? null : vatgrouppu,
    "kode_karoseri": kodeKaroseri,
    "frozen_for": frozenFor == null ? null : frozenFor,
    "frozen_from": frozenFrom,
    "frozen_to": frozenTo,
    "inventory_item": inventoryItem == null ? null : inventoryItem,
    "pricelists": pricelists == null ? null : List<dynamic>.from(pricelists.map((x) => x.toJson())),
    "stocks": stocks == null ? null : List<dynamic>.from(stocks.map((x) => x.toJson())),
  };
}

class Pricelist {
  int pricelistId;
  String pricelistCode;
  int customerGroupId;
  String itemModel;
  String itemType;
  String itemCode;
  int itemGroup;
  double offtr;
  double bbn;
  double logistic;
  double ontr;
  DateTime pricelistTanggal;
  String dalamKota;
  String customerGroupName;

  Pricelist({
    this.pricelistId,
    this.pricelistCode,
    this.customerGroupId,
    this.itemModel,
    this.itemType,
    this.itemCode,
    this.itemGroup,
    this.offtr,
    this.bbn,
    this.logistic,
    this.ontr,
    this.pricelistTanggal,
    this.dalamKota,
    this.customerGroupName,
  });

  factory Pricelist.fromJson(Map<String, dynamic> json) => Pricelist(
    pricelistId: json["pricelist_id"] == null ? null : json["pricelist_id"],
    pricelistCode: json["pricelist_code"] == null ? null : json["pricelist_code"],
    customerGroupId: json["customer_group_id"] == null ? null : json["customer_group_id"],
    itemModel: json["item_model"] == null ? null : json["item_model"],
    itemType: json["item_type"] == null ? null : json["item_type"],
    itemCode: json["item_code"] == null ? null : json["item_code"],
    itemGroup: json["item_group"] == null ? null : json["item_group"],
    offtr: json["offtr"] == null ? null : json["offtr"],
    bbn: json["bbn"] == null ? null : json["bbn"],
    logistic: json["logistic"] == null ? null : json["logistic"],
    ontr: json["ontr"] == null ? null : json["ontr"],
    pricelistTanggal: json["pricelist_tanggal"] == null ? null : DateTime.parse(json["pricelist_tanggal"]),
    dalamKota: json["dalam_kota"] == null ? null : json["dalam_kota"],
    customerGroupName: json["customer_group_name"] == null ? null : json["customer_group_name"],
  );

  Map<String, dynamic> toJson() => {
    "pricelist_id": pricelistId == null ? null : pricelistId,
    "pricelist_code": pricelistCode == null ? null : pricelistCode,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "item_model": itemModel == null ? null : itemModel,
    "item_type": itemType == null ? null : itemType,
    "item_code": itemCode == null ? null : itemCode,
    "item_group": itemGroup == null ? null : itemGroup,
    "offtr": offtr == null ? null : offtr,
    "bbn": bbn == null ? null : bbn,
    "logistic": logistic == null ? null : logistic,
    "ontr": ontr == null ? null : ontr,
    "pricelist_tanggal": pricelistTanggal == null ? null : pricelistTanggal.toIso8601String(),
    "dalam_kota": dalamKota == null ? null : dalamKota,
    "customer_group_name": customerGroupName == null ? null : customerGroupName,
  };
}

class Stock {
  String nomorRangka;
  dynamic nomorMesin;
  String whsCode;
  int quantity;
  String nomorRegister;
  dynamic nomorKunci;
  dynamic nomorRrn;
  dynamic kodeTahun;
  String tahun;
  String kodeWarna;
  String namaWarna;
  DateTime inDate;
  dynamic prodate;
  String status;
  String whsName;

  Stock({
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
    this.inDate,
    this.prodate,
    this.status,
    this.whsName,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    nomorRangka: json["nomor_rangka"] == null ? null : json["nomor_rangka"],
    nomorMesin: json["nomor_mesin"],
    whsCode: json["whs_code"] == null ? null : json["whs_code"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    nomorRegister: json["nomor_register"] == null ? null : json["nomor_register"],
    nomorKunci: json["nomor_kunci"],
    nomorRrn: json["nomor_rrn"],
    kodeTahun: json["kode_tahun"],
    tahun: json["tahun"] == null ? null : json["tahun"],
    kodeWarna: json["kode_warna"] == null ? null : json["kode_warna"],
    namaWarna: json["nama_warna"] == null ? null : json["nama_warna"],
    inDate: json["in_date"] == null ? null : DateTime.parse(json["in_date"]),
    prodate: json["prodate"],
    status: json["status"] == null ? null : json["status"],
    whsName: json["whs_name"] == null ? null : json["whs_name"],
  );

  Map<String, dynamic> toJson() => {
    "nomor_rangka": nomorRangka == null ? null : nomorRangka,
    "nomor_mesin": nomorMesin,
    "whs_code": whsCode == null ? null : whsCode,
    "quantity": quantity == null ? null : quantity,
    "nomor_register": nomorRegister == null ? null : nomorRegister,
    "nomor_kunci": nomorKunci,
    "nomor_rrn": nomorRrn,
    "kode_tahun": kodeTahun,
    "tahun": tahun == null ? null : tahun,
    "kode_warna": kodeWarna == null ? null : kodeWarna,
    "nama_warna": namaWarna == null ? null : namaWarna,
    "in_date": inDate == null ? null : inDate.toIso8601String(),
    "prodate": prodate,
    "status": status == null ? null : status,
    "whs_name": whsName == null ? null : whsName,
  };
}
