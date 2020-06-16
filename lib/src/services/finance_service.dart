import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/asset_group_model.dart';
import 'package:salles_tools/src/models/asset_kind_model.dart';
import 'package:salles_tools/src/models/asset_price_model.dart';
import 'package:salles_tools/src/models/asset_type_model.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/models/insurance_type_model.dart';
import 'package:salles_tools/src/models/outlet_model.dart';
import 'package:salles_tools/src/models/simulation_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class FinanceService {
  final Dio _dio = new Dio();

  FinanceService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future branchCode() async {
    final response = await _dio.get(UriApi.branchCodeUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(branchModelFromJson, json.encode(response.data));
    }
    print("response get branch ${response.data}");
  }

  Future outletCode(String branchCode) async {
    final response = await _dio.get(UriApi.outletCodeUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      queryParameters: {
        "branchCode": branchCode,
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(outletModelFromJson, json.encode(response.data));
    }
    print("response get outlet ${response.data}");
    
  }
  
  Future assetKind(String branchCode) async {
    final response = await _dio.get(UriApi.assetKindUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      queryParameters: {
        "branchCode": branchCode,
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(assetKindModelFromJson, json.encode(response.data));
    }
  }

  Future insuranceType(String branchCode, String assetKindCode) async {
    final response = await _dio.get(UriApi.insuranceTypeUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "branchCode": branchCode,
          "assetKind": assetKindCode,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(insuranceModelFromJson, json.encode(response.data));
    }
  }

  Future assetGroup(String branchCode, String assetKindCode, String insuranceAssetCode) async {
    final response = await _dio.get(UriApi.assetGroupUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "branchCode": branchCode,
          "assetKind": assetKindCode,
          "insuranceAssetType": insuranceAssetCode,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(assetGroupModelFromJson, json.encode(response.data));
    }
  }

  Future assetType(String branchCode, String assetKindCode, String insuranceAssetCode, String assetGroupCode) async {
    final response = await _dio.get(UriApi.assetTypeUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "branchCode": branchCode,
          "assetKind": assetKindCode,
          "insuranceAssetType": insuranceAssetCode,
          "assetGroupCode": assetGroupCode,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(assetTypeModelFromJson, json.encode(response.data));
    }
  }

  Future assetPrice(String branchCode, String assetKindCode, String insuranceAssetCode, String assetGroupCode, String assetTypeCode) async {
    final response = await _dio.get(UriApi.assetPriceUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "branchCode": branchCode,
          "assetKind": assetKindCode,
          "insuranceAssetType": insuranceAssetCode,
          "assetGroupCode": assetGroupCode,
          "assetTypeCode": assetTypeCode,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(assetPriceModelFromJson, json.encode(response.data));
    }
  }

  Future simulationDownPayment(String branchCode, String assetKindCode, String insuranceAssetCode, String assetGroupCode, String assetTypeCode, String priceListId, String price, String downPayment) async {
    final response = await _dio.get(UriApi.simulationDownPaymentUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "branchCode": branchCode,
          "assetKind": assetKindCode,
          "insuranceAssetType": insuranceAssetCode,
          "assetGroupCode": assetGroupCode,
          "assetTypeCode": assetTypeCode,
          "priceListId": priceListId,
          "price": price.replaceAll(".", ""),
          "downPayment": downPayment.replaceAll(".", ""),
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(simulationModelFromJson, json.encode(response.data));
    }
  }

  Future simulationPriceList(String branchCode, String assetKindCode, String insuranceAssetCode, String assetGroupCode, String assetTypeCode, String priceListId, String price) async {
    final response = await _dio.get(UriApi.simulationPriceListUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "branchCode": branchCode,
          "assetKind": assetKindCode,
          "insuranceAssetType": insuranceAssetCode,
          "assetGroupCode": assetGroupCode,
          "assetTypeCode": assetTypeCode,
          "priceListId": priceListId,
          "price": price.replaceAll(".", ""),
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(simulationModelFromJson, json.encode(response.data));
    }
  }

}