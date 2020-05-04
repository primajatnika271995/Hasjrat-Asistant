import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/service_station_model.dart';
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

  Future fetchCarList(ListCarBookingPost value) async {
    final response = await _dio.get(
      UriApi.testDriveCarUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      queryParameters: {
        "branch" : value.branchCode,
        "outlet" : value.outletCode,
      }
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
    if (response.statusCode == 200) {
      return compute(bookingDriveScheduleModelFromJson, json.encode(response.data));
    }
  }
  
  Future fetchListStation() async {
    final response = await _dio.get(UriApi.serviceStationListUri);

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(serviceStationModelFromJson, json.encode(response.data));
    }
  }

  Future addBookingServiceViaEmail(BookingServicePost value) async {
    final response = await _dio.post(UriApi.bookingServiceUri,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: {
        "salesName": value.salesName,
        "salesEmail": value.salesEmail,
        "bookingDate": value.bookingDate,
        "bookingTime": value.bookingTime,
        "bookingTypeName": value.bookingTypeName,
        "customerEmail": value.customerEmail,
        "customerName": value.customerName,
        "customerPhone": value.customerPhone,
        "dealerAddress": value.dealerAddress,
        "dealerEmail": value.dealerEmail,
        "dealerName": value.dealerName,
        "periodService": value.periodService,
        "serviceCategoryName": value.serviceCategoryName,
        "vehicleNumber": value.vehicleNumber,
        "emailKabeng": value.kabengEmail,
      },
    );
    log.info(response.statusCode);
    if (response.statusCode == 200) {
      log.info("Booking Service Success");
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }
}

class BookingServicePost {
  String salesName;
  String salesEmail;
  String bookingDate;
  String bookingTime;
  String bookingTypeName;
  String customerEmail;
  String customerName;
  String customerPhone;
  String dealerAddress;
  String dealerEmail;
  String dealerName;
  String periodService;
  String serviceCategoryName;
  String vehicleNumber;
  String kabengEmail;

  BookingServicePost({this.salesName, this.salesEmail, this.bookingDate, this.bookingTime, this.bookingTypeName, this.customerEmail, this.customerName, this.customerPhone, this.dealerAddress, this.dealerName, this.dealerEmail, this.periodService, this.serviceCategoryName, this.vehicleNumber, this.kabengEmail});
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

class ListCarBookingPost {
  String branchCode;
  String outletCode;

  ListCarBookingPost({
    this.branchCode,
    this.outletCode,
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
