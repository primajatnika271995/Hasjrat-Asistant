import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/models/location_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CustomerService {
  final Dio _dio = new Dio();

  CustomerService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future customerDMS(CustomerPost value) async {
    final response = await _dio.post(UriApi.checkCustomerDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      data: {
        "cardcode": value.cardCode,
        "cardname": value.cardName,
        "custgroup": value.custgroup,
      },
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(customerModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future leadDMS(LeadPost value) async {
    final response = await _dio.post(UriApi.checkLeadDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      data: {
        "lead_code": value.leadCode,
        "lead_name": value.leadName,
      },
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(leadModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future gender(String val) async {
    final response = await _dio.post(UriApi.genderDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      queryParameters: {
        "val": val,
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(genderModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future location(String val) async {
    final response = await _dio.post(UriApi.locationDMSUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "val": val,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(locationModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future job(String val) async {
    final response = await _dio.post(UriApi.jobDMSUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        queryParameters: {
          "val": val,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(jobModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future province() async {
    final response = await _dio.post(UriApi.provinceUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        )
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(provinceModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }
}

class CustomerPost {
  String cardCode;
  String cardName;
  String custgroup;

  CustomerPost({this.cardCode, this.cardName, this.custgroup});
}

class LeadPost {
  String leadCode;
  String leadName;

  LeadPost({this.leadCode, this.leadName});
}