import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/configs/url.dart';
//model
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/models/check_stock_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import'package:salles_tools/src/models/branch_stock_model.dart';

class CheckStockService {
  final Dio _dio = new Dio();

  CheckStockService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  // post stok kendaraan HO
  Future postCheckStock(CekStoKHeadOfficePost value) async {
    final response = await _dio.post(
      UriApi.cekStoc_Ho_Uri,
      options: Options(
        headers: {
          'Content-type': 'application/json',
        },
      ),
      data: {
        "branchCode": value.branchCode,
        "class1": value.jenisKendaraan,
        "model": value.modelKendaraan,
        "itemType": value.tipeKendaraan,
        "itemCode": value.kodeKendaraan,
      },
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(checkStockModelFromJson, json.encode(response.data));
    }
  }

  //get branchCode List
  Future getBranchCode() async {
    final response = await _dio.get(
      UriApi.branchCodeStock,
      options: Options(headers: {'Content-type': 'application/json'}),
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(branchStockModelFromJson, json.encode(response.data));
    }
  }

  // fetch jenis kendaraan dms
  Future postJenisKendaraan() async {
    final response = await _dio.post(
      UriApi.class1ItemDMSUri,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(class1ItemModelFromJson, json.encode(response.data));
    }
  }

  Future postModelKendaraan(ModelKendaraanPost value) async {
    final response = await _dio.post(UriApi.itemModelDMSUri,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "item_class": value.itemClass,
          "item_class1": value.itemClass1,
          "item_model": value.itemModel,
          "item_type": value.itemType
        });

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(itemModelFromJson, json.encode(response.data));
    }
  }

  Future postKodeKendaraan(KodeKendaraanPost value) async {
    final response = await _dio.post(UriApi.priceListDMSUri,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {"custgroup": value.cGroup, "itemcode": value.itemCode});

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(priceListModelFromJson, json.encode(response.data));
    }
  }

  Future postStockKendaraan(CekStoKHeadOfficePost value) async {
    final response = await _dio.post(
      UriApi.cekStoc_Ho_Uri,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {"branchCode": value.branchCode},
    );
  }
}

class ModelKendaraanPost {
  String itemClass;
  String itemClass1;
  String itemModel;
  String itemType;

  ModelKendaraanPost(
      {this.itemClass, this.itemClass1, this.itemModel, this.itemType});
}

class KodeKendaraanPost {
  String cGroup;
  String itemCode;

  KodeKendaraanPost({this.cGroup, this.itemCode});
}

class CekStoKHeadOfficePost {
  String branchCode;
  String jenisKendaraan;
  String modelKendaraan;
  String tipeKendaraan;
  String kodeKendaraan;

  CekStoKHeadOfficePost(
      {this.branchCode,
      this.jenisKendaraan,
      this.modelKendaraan,
      this.tipeKendaraan,
      this.kodeKendaraan});
}
