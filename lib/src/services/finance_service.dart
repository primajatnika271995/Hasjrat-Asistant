import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class FinanceService {
  final Dio _dio = new Dio();

  FinanceService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future branchCode() async {
    final response = await _dio.post(UriApi.branchCodeUri,
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
  }
}