import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/changePasswordModel.dart';
import 'package:salles_tools/src/models/employee_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';

class LoginService {
  final Dio _dio = new Dio();

  final clientId = 'sales-tools-mobile';
  final clientSecret = '123456';

  LoginService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future login(String username, String password) async {
    await SharedPreferencesHelper.setAccessToken(null);

    var params = {
      "username": username,
      "password": password,
      "grant_type": "password",
    };

    try {
      final response = await _dio.post(UriApi.loginUri,
        data: FormData.fromMap(params),
        options: Options(
            headers: {
              'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}'
            }
        ),
      );
      log.info(response.statusCode);
      if (response.statusCode == 200) {
        return compute(authenticationModelFromJson, json.encode(response.data));
      }
    } on DioError catch (error) {
      log.warning("Login Error Status: ${error.response.statusCode}");
      log.warning(error.response.data);
      if (error.response.statusCode == 401) {
        return compute(authenticationModelFromJson, json.encode(error.response.data));
      } else if (error.response.statusCode == 502) {
        return compute(errorModelFromJson, json.encode(error.response.data));
      } else if (error.response.statusCode == 400) {
        log.info("Error 400");
      }
    }
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

  Future changePassword(String username, String password) async {
    try {
      final response = await _dio.post(UriApi.changePasswordUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        data: {
          "password": password,
          "username": username
        },
      );

      log.info(response.statusCode);
      return compute(changePasswordModelFromJson, json.encode(response.data));

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