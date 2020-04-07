import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/upload_media_model.dart';
import 'package:salles_tools/src/services/upload_media_service.dart';
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
  
  Future createActivityReport(ActivityReportPost value) async {
    final response = await _dio.post(UriApi.createActivityReportUri,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: {
        "title": value.title,
        "latitude": 0,
        "longitude": 0,
        "alamat": value.alamat,
        "description": value.description,
        "files": [
          value.idContent,
        ],
        "createdInMillisecond": value.createdInMillisecond
      },
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("Success Create Activity Report");
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future uploadFile(File image) async {
    FormData formData = FormData.fromMap({
      "content": await MultipartFile.fromFile(image.path, filename: "activity-report.png")
    });

    try {
      final response = await _dio.post(UriApi.uploadMediaFileUri, data: formData);

      log.info(response.statusCode);
      if (response.statusCode == 200) {
        return compute(uploadMediaModelFromJson, json.encode(response.data));
      }
    } catch(error) {
      log.warning(error.toString());
    }
  }
}

class ActivityReportPost {
  String title;
  String idContent;
  dynamic latitude;
  dynamic longitude;
  String alamat;
  String description;
  int createdInMillisecond;

  ActivityReportPost({this.title, this.idContent, this.latitude, this.longitude, this.alamat, this.description, this.createdInMillisecond});
}