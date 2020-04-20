import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/spk_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class SpkService {
  final Dio _dio = new Dio();

  SpkService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future spkList(SpkFilterPost value, String start, String limit) async {
    try {
      final response = await _dio.post(
        UriApi.spkUri,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "card_code": value.cardCode,
          "card_name": value.cardName,
          "end_date": value.endDate,
          "limit": limit,
          "spk_blanko": value.spkBlanko,
          "spk_num": value.spkNum,
          "start": start,
          "start_date": value.startDate
        },
      );

      log.info(response.statusCode);
      if (response.statusCode == 200) {
        return compute(spkModelFromJson, json.encode(response.data));
      }
    } on DioError catch (error) {
      log.warning("Prospect Error Status: ${error.response.statusCode}");

      if (error.response.statusCode == 502) {
        return compute(errorModelFromJson, json.encode(error.response.data));
      } else if (error.response.statusCode == 401) {
        return compute(errorTokenExpireFromJson, json.encode(error.response.data));
      } else {
        return compute(errorModelFromJson, json.encode(error.response.data));
      }
    }
  }
}

class SpkFilterPost {
  String cardCode;
  String cardName;
  String endDate;
  String startDate;
  String spkBlanko;
  String spkNum;

  SpkFilterPost({this.cardCode, this.cardName, this.endDate, this.startDate, this.spkBlanko, this.spkNum});
}