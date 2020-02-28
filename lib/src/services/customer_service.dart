import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CustomerService {
  final Dio _dio = new Dio();

  CustomerService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future customerDMS(CustomerPost value) async {
    try {
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
      } else {
        return compute(errorModelFromJson, json.encode(response.data));
      }

    } catch(error) {
      log.warning("Err : ${error.toString()}");
    }

    return null;
  }
}

class CustomerPost {
  String cardCode;
  String cardName;
  String custgroup;

  CustomerPost({this.cardCode, this.cardName, this.custgroup});
}