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
import 'package:salles_tools/src/models/stnk_expired_model.dart';
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
      }
    } on DioError catch(error) {
      log.warning("Customer Error Status: ${error.response.statusCode}");

      if (error.response.statusCode == 502) {
        return compute(errorModelFromJson, json.encode(error.response.data));
      } else if (error.response.statusCode == 401) {
        return compute(errorTokenExpireFromJson, json.encode(error.response.data));
      } else {
        return compute(errorModelFromJson, json.encode(error.response.data));
      }
    }
  }

  Future leadDMS(LeadPost value, String start, String limit) async {

    try {
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
      }
    } on DioError catch(error) {
      log.warning("Lead Error Status: ${error.response.statusCode}");

      if (error.response.statusCode == 502) {
        return compute(errorModelFromJson, json.encode(error.response.data));
      } else if (error.response.statusCode == 401) {
        return compute(errorTokenExpireFromJson, json.encode(error.response.data));
      } else {
        return compute(errorModelFromJson, json.encode(error.response.data));
      }
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
        "card_name": value.customerName,
        "no_ktp": value.noKtp,
        "group_code": 100,
        "customer_group_id": value.customerGroupId,
        "gender": value.gender,
        "phone1": value.contact,
        "phone2": "",
        "phone3": "",
        "location": value.location,
        "pekerjaan": value.job,
        "suspect_date": value.suspectDate,
        "prospect_source_id": value.prospectSourceId,
        "suspect_followup": value.suspectFollowUp,
        "addresses": [
          {
            "address1": value.kabupatenName,
            "address2": value.kecamatanName,
            "address3": value.provinceName,
            "provinsi_code": value.provinceCode,
            "kabupaten_code": value.kabupatenCode,
            "kecamatan_code": value.kecamatanCode,
            "zipcode": value.zipCode
          }
        ]
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

  Future expiredSTNK() async {
    final response = await _dio.post(UriApi.listExpiredStnkUri,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(stnkExpiredModelFromJson, json.encode(response.data));
    } else if (response.statusCode == 401) {
      return compute(errorTokenExpireFromJson, json.encode(response.data));
    } else {
      return compute(errorModelFromJson, json.encode(response.data));
    }
  }

  Future allSTNK() async {
    final response = await _dio.post(UriApi.listAllStnkUri,
      options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(stnkExpiredModelFromJson, json.encode(response.data));
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
  String noKtp;
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

  ContactPost({this.customerName, this.noKtp, this.customerGroupId, this.gender, this.location, this.job, this.contact, this.prospectSourceId, this.suspectDate, this.suspectFollowUp, this.provinceName, this.provinceCode, this.kabupatenName, this.kabupatenCode, this.kecamatanName, this.kecamatanCode, this.zipCode});
}