import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class DmsService {
  final Dio _dio = new Dio();

  DmsService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future class1() async {
    final response = await _dio.post(UriApi.class1ItemDMSUri,
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
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(itemModelFromJson, json.encode(response.data));
    }
  }

  Future priceList(PriceListPost value) async {
    final response = await _dio.post(UriApi.priceListDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
      ),
      data: {
        "custgroup": value.custGroup,
        "itemcode": value.itemCode
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(priceListModelFromJson, json.encode(response.data));
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

  ItemModelPost({this.itemClass, this.itemClass1, this.itemModel, this.itemType});
}