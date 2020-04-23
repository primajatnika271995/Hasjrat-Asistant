import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/classification_followup_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/followup_methode_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class FollowupService {
  final Dio _dio = new Dio();

  FollowupService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future classificationList() async {
    final response = await _dio.get(UriApi.classificationFollowUpUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        )
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(classificationFollowUpModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future followUpMethodeList() async {
    final response = await _dio.get(UriApi.followUpMethodeUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        )
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(followUpMethodeModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future updateFollowup(FollowUpParams value) async {
    final response = await _dio.post(UriApi.createSpkUri,
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: {
        "followup_next_day": value.followUpNextDay,
        "line_num": value.lineNum,
        "prospect_classification_id": value.prospectClassificationId,
        "prospect_followup_id": value.prospectFollowUpId,
        "prospect_followup_method_id": value.prospectFollowUpMethodeId,
        "prospect_id": value.prospectId,
        "prospect_remarks": value.prospectRemarks
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("OK DONE");
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }
}

class FollowUpParams {
  int followUpNextDay;
  int lineNum;
  int prospectClassificationId;
  int prospectFollowUpId;
  int prospectFollowUpMethodeId;
  int prospectId;
  String prospectRemarks;

  FollowUpParams({this.followUpNextDay, this.lineNum, this.prospectClassificationId, this.prospectFollowUpId, this.prospectFollowUpMethodeId, this.prospectId, this.prospectRemarks});
}