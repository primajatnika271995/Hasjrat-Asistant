import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/dashboard_model.dart';
import 'package:salles_tools/src/models/dashboard_target_model.dart';
import 'package:salles_tools/src/services/catalog_service.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:flutter/foundation.dart';

class DashboardService {
  final Dio _dio = new Dio();

  DashboardService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future fetchDashboard() async {
    final response = await _dio.get(
      UriApi.dashboardUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("SUCCESS GET DASHBOARD DATA");
      return compute(dashboardModelFromJson, json.encode(response.data));
    }
  }

  Future fetchTargetDashboard(TargetDashboardPost value) async {
    final response = await _dio.get(UriApi.dashboardTargetUri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        queryParameters: {
          "employeeId": value.employeeId,
        });
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("SUCCESS GET TARGET DASHBOARD DATA");
      return compute(targetDashboardModelFromJson, json.encode(response.data));
    }
  }
}

class TargetDashboardPost {
  String employeeId;

  TargetDashboardPost({this.employeeId});
}
