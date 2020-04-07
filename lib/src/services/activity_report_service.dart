import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class ActivityReportService {
  final Dio _dio = new Dio();

  ActivityReportService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future activityReport() async {
    try {
      final response = await _dio.post(UriApi.activityReportListUri);

      log.info(response.statusCode);
      return compute(activityReportModelFromJson, json.encode(response.data));
    } catch(error) {
      log.warning(error.toString());
    }
  }
}