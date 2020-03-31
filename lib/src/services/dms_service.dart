import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/item_list_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import 'package:salles_tools/src/models/program_penjualan_model.dart';
import 'package:salles_tools/src/models/prospect_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

import '../models/error_model.dart';
import '../models/error_token_expire_model.dart';

class DmsService {
  final Dio _dio = new Dio();

  DmsService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future class1() async {
    final response = await _dio.post(
      UriApi.class1ItemDMSUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(class1ItemModelFromJson, json.encode(response.data));
    }
  }

  Future itemModel(ItemModelPost value) async {
    final response = await _dio.post(UriApi.itemModelDMSUri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
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

  Future itemList(ItemListPost value) async {
    final response = await _dio.post(UriApi.itemListDMSUri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "custgroup": value.customerGroup,
          "itemcode": value.itemCode,
          "itemgroup": value.itemGroup
        });

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(itemListModelFromJson, json.encode(response.data));
    }
  }

  Future priceList(PriceListPost value) async {
    final response = await _dio.post(UriApi.priceListDMSUri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {"custgroup": value.custGroup, "itemcode": value.itemCode});

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(priceListModelFromJson, json.encode(response.data));
    }
  }

  Future prospectDMS(ProspectGet value, String start, String limit) async {
    try {
      final response = await _dio.post(
        UriApi.checkProspectDMSUri,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "lead_code": value.leadCode,
          "lead_name": value.leadName,
          "limit": limit,
          "start": start
        },
      );

      log.info(response.statusCode);
      if (response.statusCode == 200) {
        return compute(prospectModelFromJson, json.encode(response.data));
      }
    } on DioError catch (error) {
      log.warning("Prospect Error Status: ${error.response.statusCode}");

      if (error.response.statusCode == 502) {
        return compute(errorModelFromJson, json.encode(error.response.data));
      } else if (error.response.statusCode == 401) {
        return compute(
            errorTokenExpireFromJson, json.encode(error.response.data));
      } else {
        return compute(errorModelFromJson, json.encode(error.response.data));
      }
    }
  }

  Future createProspect(ProspectPost value) async {
    final response = await _dio.post(
      UriApi.createProspectDMSUri,
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: {
        "card_code": "",
        "card_name": value.cardName,
        "customer_group_id": value.customerGroupId,
        "from_suspect": "Y",
        "is_fleet": "N",
        "lead_code": value.leadCode,
        "models": [
          {
            "item_code": value.itemCode,
            "item_colour": value.itemColor,
            "item_model": value.itemModel,
            "item_type": value.itemType,
            "item_year": value.itemYear,
            "price": value.price,
            "quantity": value.quantity
          }
        ],
        "payment_type_id": 2,
        "prospect_classification_id": 2,
        "prospect_date": value.prospectDate,
        "prospect_first_vehicle": "",
        "prospect_followup": 7,
        "prospect_source_id": 10,
        "trade_in": "N"
      },
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("OK DONE");
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future fetchListProgramPenjualan(ProgramPenjualanPost value) async {
    final response = await _dio.post(
      UriApi.programPenjualanUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        "name": value.name,
        "programId": value.programId,
      },
    );
    log.info(response.statusCode);
    print("status code => ${response.statusCode}");
    if (response.statusCode == 200) {
      log.info("SUCCESS FETCH LIST PROGRAM PENJUALAN");
      return compute(programPenjualanModelFromJson, json.encode(response.data));
    }
  }
}

class PriceListPost {
  String custGroup;
  String itemCode;

  PriceListPost({this.custGroup, this.itemCode});
}

class ItemModelPost {
  String itemClass;
  String itemClass1;
  String itemModel;
  String itemType;

  ItemModelPost(
      {this.itemClass, this.itemClass1, this.itemModel, this.itemType});
}

class ItemListPost {
  String customerGroup;
  String itemCode;
  String itemGroup;

  ItemListPost({this.customerGroup, this.itemCode, this.itemGroup});
}

class ProspectGet {
  String leadCode;
  String leadName;

  ProspectGet({this.leadCode, this.leadName});
}

class ProspectPost {
  String cardName;
  String customerGroupId;
  String fromSuspect;
  String leadCode;
  String itemCode;
  String itemColor;
  String itemModel;
  String itemType;
  String itemYear;
  dynamic price;
  String quantity;
  String prospectDate;
  int prospectFollowUp;

  ProspectPost(
      {this.cardName,
      this.customerGroupId,
      this.fromSuspect,
      this.leadCode,
      this.itemCode,
      this.itemColor,
      this.itemModel,
      this.itemType,
      this.itemYear,
      this.price,
      this.quantity,
      this.prospectDate,
      this.prospectFollowUp});
}

class ProgramPenjualanPost {
  String name;
  String programId;
  ProgramPenjualanPost({
    this.name,
    this.programId,
  });
}
