import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/district_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/models/location_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
import 'package:salles_tools/src/models/sub_district_model.dart';
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

  Future leadDMS(LeadPost value, String start, String limit) async {
    final response = await _dio.post(UriApi.checkLeadDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      data: {
        "lead_code": value.leadCode,
        "lead_name": value.leadName,
        "limit": limit,
        "start": start
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

  Future district(String provinceCode) async {
    final response = await _dio.post(UriApi.districtUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
      data: {
        "kabupaten_code": "",
        "kabupaten_name": "",
        "provinsi_code": provinceCode,
      }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(districtModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future subDistrict(String provinceCode, String kabupatenCode) async {
    final response = await _dio.post(UriApi.subDistrictUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        data: {
          "kabupaten_code": kabupatenCode,
          "kabupaten_name": "",
          "provinsi_code": provinceCode,
        }
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(subDistrictModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future createLead(ContactPost value) async {
    final response = await _dio.post(UriApi.createLeadDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      data: {
        "addresses": [
          {
            "address1": value.kabupatenName,
            "address2": value.kecamatanName,
            "addres s3": value.provinceName,
            "kabupaten_code": value.kabupatenCode,
            "kecamatan_code": value.kecamatanCode,
            "provinsi_code": value.provinceCode,
            "zipcode": value.zipCode
          }
        ],
        "card_name": value.customerName,
        "customer_group_id": value.customerGroupId,
        "gender": value.gender,
        "groupCode": 100,
        "location": value.location,
        "pekerjaan": value.job,
        "phone1": value.contact,
        "phone2": "",
        "phone3": "",
        "prospect_source_id": value.prospectSourceId,
        "suspect_date": value.suspectDate,
        "suspect_followup": 7
      },
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

  Future createProspect(ProspectPost value) async {
    final response = await _dio.post(UriApi.createProspectDMSUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
      data: {
        "card_code": "",
        "card_name": value.cardName,
        "customer_group_id": value.customerGroupId,
        "from_suspect": "Y",
        "is_fleet": "N",
        "lead_code": "N",
        "models": [
          {
            "item_code": value.itemCode,
            "item_colour": value.itemColor,
            "item_model": value.itemModel,
            "item_type": value.itemType,
            "item_year": value.itemYear,
            "price": value.price,
            "quantity": value.quantity
          }
        ],
        "payment_type_id": 2,
        "prospect_classification_id": 2,
        "prospect_date": value.prospectDate,
        "prospect_first_vehicle": "",
        "prospect_followup": 7,
        "prospect_source_id": 10,
        "trade_in": "N"
      },
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

class ContactPost {
  String customerName;
  int customerGroupId;
  String gender;
  String location;
  String job;
  String contact;
  int prospectSourceId;
  String suspectDate;
  int suspectFollowUp;
  String provinceName;
  String provinceCode;
  String kabupatenName;
  String kabupatenCode;
  String kecamatanName;
  String kecamatanCode;
  String zipCode;

  ContactPost({this.customerName, this.customerGroupId, this.gender, this.location, this.job, this.contact, this.prospectSourceId, this.suspectDate, this.suspectFollowUp, this.provinceName, this.provinceCode, this.kabupatenName, this.kabupatenCode, this.kecamatanName, this.kecamatanCode, this.zipCode});
}

class ProspectPost {
  String cardName;
  String customerGroupId;
  String fromSuspect;
  String leadCode;
  String itemCode;
  String itemColor;
  String itemModel;
  String itemType;
  String itemYear;
  dynamic price;
  String quantity;
  String prospectDate;
  String prospectFollowUp;

  ProspectPost({this.cardName, this.customerGroupId, this.fromSuspect, this.leadCode, this.itemCode, this.itemColor, this.itemModel, this.itemType, this.itemYear, this.price, this.quantity, this.prospectDate, this.prospectFollowUp});
}