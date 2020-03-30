import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/test_drive_vehicle_model.dart';
import 'package:salles_tools/src/models/list_booking_drive_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

import '../configs/url.dart';

class BookingDriveService {
  final Dio _dio = new Dio();

  BookingDriveService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future fetchCarList() async {
    final response = await _dio.get(
      UriApi.testDriveCarUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(testDriveVehicleModelFromJson, json.encode(response.data));
    }
  }

  Future registerBookingTestDrive(BookingTestDrivePost value) async {
    final response = await _dio.post(
      UriApi.registerBookingTestDriveUri,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: {
        "customerName": value.customerName,
        "customerPhone": value.customerPhone,
        "branchCode": value.branchCode,
        "outletCode": value.outletCode,
        "carId": value.carId,
        "notes": value.notes,
        "scheduleInMillisecond": value.schedule,
      },
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("REGISTER BOOKING TEST DRIVE SUCCEESS");
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future fetchListSchedule(ListBookingDrivePost value) async {
    final response = await _dio.post(
      UriApi.listScheduleBookingDriveUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        "branchCode": value.branchCode,
        "dateAfter": value.dateAfter,
        "dateBefore": value.dateBefore,
        "outletCode": value.outletCode,
      },
    );
    log.info(response.statusCode);
    print("status code => ${response.statusCode}");
    if (response.statusCode == 200) {
      log.info("SUCCESS FETCH LIST SCHEDULE BOOKING DRIVE");
      return compute(bookingDriveScheduleModelFromJson, json.encode(response.data));
    }
  }
}

class BookingTestDrivePost {
  String customerName;
  String customerPhone;
  String notes;
  String branchCode;
  String outletCode;
  String carId;
  int schedule;

  BookingTestDrivePost({
    this.customerName,
    this.customerPhone,
    this.notes,
    this.branchCode,
    this.outletCode,
    this.carId,
    this.schedule,
  });
}

class ListBookingDrivePost {
  String branchCode;
  String outletCode;
  String dateAfter;
  String dateBefore;

  ListBookingDrivePost({
    this.branchCode,
    this.outletCode,
    this.dateAfter,
    this.dateBefore,
  });
}
