import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/knowledge_base_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class KnowledgeBaseService {
  final Dio _dio = new Dio();
  final clientId = 'sales-tools-mobile';
  final clientSecret = '123456';

  KnowledgeBaseService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future questionAsk() async {
    try {
      final response = await _dio.post(
        UriApi.knowledgeBaseUri,
        queryParameters: {
          // "order%5B0%5D%5Bcolumn%5D": 3,
          // "order%5B0%5D%5Bdir%5D": "desc",
          // "length" : 66,
        },
      );

      log.info(response.statusCode);
      return compute(knowladgeBaseModelFromJson, json.encode(response.data));
    } catch (error) {
      log.warning(error.toString());
    }
    return null;
  }
}
