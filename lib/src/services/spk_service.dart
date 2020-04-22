import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salles_tools/src/configs/url.dart';
import 'package:salles_tools/src/models/customer_criteria_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/error_token_expire_model.dart';
import 'package:salles_tools/src/models/leasing_model.dart';
import 'package:salles_tools/src/models/leasing_tenor_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
import 'package:salles_tools/src/models/spk_model.dart';
import 'package:salles_tools/src/models/spk_number_model.dart';
import 'package:salles_tools/src/utils/dio_logging_interceptors.dart';
import 'package:salles_tools/src/views/components/log.dart';

class SpkService {
  final Dio _dio = new Dio();

  SpkService() {
    _dio.options.baseUrl = UriApi.baseApi;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
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

  Future spkNumberList() async {
    final response = await _dio.get(
      UriApi.spkNumberUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(spkNumberModelFromJson, json.encode(response.data));
    }
  }

  Future customerCriteriaList() async {
    final response = await _dio.get(
      UriApi.customerCriteriaUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(customerCriteriaModelFromJson, json.encode(response.data));
    }
  }

  Future leasingList() async {
    final response = await _dio.get(
      UriApi.leasingUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(leasingModelFromJson, json.encode(response.data));
    }
  }

  Future leasingTenorList() async {
    final response = await _dio.get(
      UriApi.leasingTenorUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    log.info(response.statusCode);
    if (response.statusCode == 200) {
      return compute(leasingTenorModelFromJson, json.encode(response.data));
    }
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

  Future createSpk(SpkParams value) async {
    final response = await _dio.post(UriApi.createSpkUri,
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: {
        "afi": {
          "address1": value.address1,
          "address2": value.address2,
          "address3": value.address3,
          "kabupaten_name": value.kabupatenName,
          "kecamatan_name": value.kecamatanName,
          "nama1": value.nama1,
          "nama2": value.nama2,
          "nama3": value.nama3,
          "nomor_ktp": value.nomorKtp,
          "plat_id": value.platId,
          "provinsi_code": value.provinsiCode,
          "provinsi_name": value.provinsiName,
          "zipcode": value.zipCode
        },
        "bonus_acc_amount": value.bonusAccAmount,
        "bonus_acc_desc": value.bonusAccDesc,
        "card_code": value.cardCode,
        "card_name": value.cardName,
        "card_type": value.cardType,
        "credits": {
          "angsuran": value.angsuran,
          "dp_amount": value.dpAmount,
          "insurance_amount_non_hmf": value.insuranceAmountNonHmf,
          "insurance_type": value.insuranceType,
          "leasing_id": value.leasingId,
          "nama_asuransi": value.namaAsuransi,
          "tenor": value.tenor
        },
        "customer_criteria": value.customerCriteria,
        "customer_group_id": value.customerGroupId,
        "dec_date": value.decDate,
        "disc_amount": value.discAmount,
        "doc_total": value.docTotal,
        "extra_bbn_price": value.extraBbnPrice,
        "is_dalamkota": value.isDalamKota,
        "item_group": value.itemGroup,
        "models": [
          {
            "item_code": value.itemCode,
            "item_colour": value.itemColour,
            "item_model": value.itemModel,
            "item_type": value.itemType,
            "item_year": value.itemYear,
            "pl_bbn": value.plBbn,
            "pl_logistic": value.plLogistic,
            "pl_offtr": value.plOfftr,
            "pl_ontr": value.plOntr,
            "price": value.price,
            "prospect_line_num": value.prospectLineNum,
            "prospect_model_id": value.prospectModelId,
            "quantity": value.quantity
          }
        ],
        "nama_user": value.namaUser,
        "payment_type_id": value.paymentTypeId,
        "pl_price": value.plPrice,
        "prospect_id": value.prospectId,
        "prospect_model_id": value.prospectModelId,
        "sales_code": value.salesCode,
        "spk_blanko": value.spkBlanko,
        "spk_date": value.spkDate,
        "spk_num": value.spkNum,
        "spk_price": value.spkPrice,
        "spk_price_type": value.spkPriceType,
        "telp_user": value.telpUser,
        "total_disc_amount": value.totalDiscAmount
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

class SpkFilterPost {
  String cardCode;
  String cardName;
  String endDate;
  String startDate;
  String spkBlanko;
  String spkNum;

  SpkFilterPost({this.cardCode, this.cardName, this.endDate, this.startDate, this.spkBlanko, this.spkNum});
}

class SpkParams {
  String address1;
  String address2;
  String address3;
  String kabupatenName;
  String kecamatanName;
  String nama1;
  String nama2;
  String nama3;
  String nomorKtp;
  int platId;
  String provinsiCode;
  String provinsiName;
  String zipCode;
  dynamic bonusAccAmount;
  String bonusAccDesc;
  String cardCode;
  String cardName;
  String cardType;
  dynamic angsuran;
  dynamic dpAmount;
  int insuranceAmountNonHmf;
  String insuranceType;
  int leasingId;
  String namaAsuransi;
  int tenor;
  int customerCriteria;
  int customerGroupId;
  String decDate;
  dynamic discAmount;
  dynamic docTotal;
  dynamic extraBbnPrice;
  String isDalamKota;
  int itemGroup;
  String itemCode;
  String itemColour;
  String itemModel;
  String itemType;
  String itemYear;
  dynamic plBbn;
  dynamic plLogistic;
  dynamic plOfftr;
  dynamic plOntr;
  dynamic price;
  int prospectLineNum;
  int prospectModelId;
  int quantity;
  String namaUser;
  int paymentTypeId;
  dynamic plPrice;
  int prospectId;
  int salesCode;
  String spkBlanko;
  String spkDate;
  String spkNum;
  dynamic spkPrice;
  String spkPriceType;
  String telpUser;
  dynamic totalDiscAmount;

  SpkParams({
    this.address1,
    this.address2,
    this.address3,
    this.kabupatenName,
    this.kecamatanName,
    this.nama1,
    this.nama2,
    this.nama3,
    this.nomorKtp,
    this.platId,
    this.provinsiCode,
    this.provinsiName,
    this.zipCode,
    this.bonusAccAmount,
    this.bonusAccDesc,
    this.cardCode,
    this.cardName,
    this.cardType,
    this.angsuran,
    this.dpAmount,
    this.insuranceAmountNonHmf,
    this.insuranceType,
    this.leasingId,
    this.namaAsuransi,
    this.tenor,
    this.customerCriteria,
    this.customerGroupId,
    this.decDate,
    this.discAmount,
    this.docTotal,
    this.extraBbnPrice,
    this.isDalamKota,
    this.itemGroup,
    this.itemCode,
    this.itemColour,
    this.itemModel,
    this.itemType,
    this.itemYear,
    this.plBbn,
    this.plLogistic,
    this.plOfftr,
    this.plOntr,
    this.price,
    this.prospectLineNum,
    this.prospectModelId,
    this.quantity,
    this.namaUser,
    this.paymentTypeId,
    this.plPrice,
    this.prospectId,
    this.salesCode,
    this.spkBlanko,
    this.spkDate,
    this.spkNum,
    this.spkPrice,
    this.spkPriceType,
    this.telpUser,
    this.totalDiscAmount,
  });
}