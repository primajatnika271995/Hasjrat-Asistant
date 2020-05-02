import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/sales_of_the_month_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class SalesMonthService {
  final Dio _dio = new Dio();
  final clientId = 'sales-tools-mobile';
  final clientSecret = '123456';

  SalesMonthService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future lastSalesMonth(SalesMonthPost value) async {
    try {
      final response = await _dio.get(UriApi.checkLastSalesOfTheMonth,
        queryParameters: {
          'branchCode': value.branchCode,
          'outletCode': value.outletCode,
        },
      );
      log.info(response.statusCode);
      return compute(salesOfTheMonthModelFromJson, json.encode(response.data));
    } catch (error) {
      log.warning(error.toString());
    }
    return null;
  }
}

class SalesMonthPost {
  String branchCode;
  String outletCode;

  SalesMonthPost({this.branchCode, this.outletCode});
}