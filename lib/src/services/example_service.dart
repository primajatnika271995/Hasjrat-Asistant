import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/example_models.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class ExampleService {
  final Dio _dio = new Dio();
  final clientId = 'example-service';
  final clientSecret = '12345';

  ExampleService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<ExampleModel> example(String username, String password) async {
    var params = {
      "username": username,
      "password": password,
      "grant_type": "password",
    };

    try {
      final response = await _dio.post(
        "example.uri",
        data: FormData.fromMap(params),
        options: Options(
          headers: {
            'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}'
          },
        ),
      );
      log.info(response.statusCode);
      return compute(authenticatedFromJson, json.encode(response.data));
    } catch (error) {
      log.warning(error.toString());
    }
    return null;
  }

}