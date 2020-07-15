import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/check_stock_model.dart';

class CheckStockService {
  final Dio _dio = new Dio();

  CheckStockService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future postCheckStock() async {
    final response = await _dio.post(
      UriApi.cekStoc_Ho_Uri,
      options: Options(
        headers: {
          'Content-type': 'application/json',
        },
      ),
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("SUKSES POST CEK STOCK");
      return compute(checkStockModelFromJson, json.encode(response.data));
    }
  }
}
