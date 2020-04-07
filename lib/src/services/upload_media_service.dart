import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/upload_media_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class UploadMediaService {
  final Dio _dio = new Dio();

  UploadMediaService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<Response> saveContentFile(File image) async {
    FormData formData = FormData.fromMap({
      "content": await MultipartFile.fromFile(image.path, filename: "activity-report.png")
    });

    final response = await _dio.post(UriApi.uploadMediaFileUri, data: formData);

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return response.data;
    }
    return response.data;
  }
}