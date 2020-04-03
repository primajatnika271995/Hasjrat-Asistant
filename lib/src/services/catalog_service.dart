import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/banner_model.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CatalogService {
  final Dio _dio = new Dio();

  CatalogService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future fetchCatalogList() async {
    final response = await _dio.get(
      UriApi.catalogListUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("SUCCESS GET CATALOG LIST");
      return compute(catalogModelFromJson, json.encode(response.data));
    }
  }

  Future bannerPromotion() async {
    final response = await _dio.post(UriApi.bannerPromotionUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(bannerModelFromJson, json.encode(response.data));
    }
  }
}
