import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/employee_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class LoginService {
  final Dio _dio = new Dio();
  final clientId = 'sales-api';
  final clientSecret = '123456';

  LoginService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<AuthenticationModel> login(String username, String password) async {
    var params = {
      "username": username,
      "password": password,
      "grant_type": "password",
    };

    try {
      final response = await _dio.post(
        UriApi.loginUri,
        data: FormData.fromMap(params),
        options: Options(
          headers: {
            'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}'
          },
        ),
      );
      log.info(response.statusCode);
      return compute(authenticationModelFromJson, json.encode(response.data));
    } catch (error) {
      log.warning(error.toString());
    }
    return null;
  }

  Future<EmployeeModel> checkNIK(String nik) async {
    try {
      final response = await _dio.get(UriApi.checkEmployeeUri + '/$nik/findEmployeeMutationById',
        queryParameters: {
        'isMutation': false,
        },
      );
      log.info(response.statusCode);
      return compute(employeeModelFromJson, json.encode(response.data));
    } catch (error) {
      log.warning(error.toString());
    }
    return null;
  }

  Future<EmployeeModel> register(RegisterPost value) async {
    try {
      final response = await _dio.post(UriApi.registerUri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
        ),
        data: {
          "username": value.username,
          "password": value.password,
          "email": value.email
        },
      );

      log.info(response.statusCode);
      return compute(employeeModelFromJson, json.encode(response.data));

    } catch (error) {
      log.warning("Err : ${error.toString()}");
    }
    return null;
  }
}

class RegisterPost {
  String username;
  String password;
  String email;

  RegisterPost({this.username, this.password, this.email});
}