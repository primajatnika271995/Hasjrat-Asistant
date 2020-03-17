import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_event.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_state.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  CustomerService _customerService;
  LeadBloc(this._customerService);

  @override
  // TODO: implement initialState
  LeadState get initialState => LeadInitial();

  @override
  Stream<LeadState> mapEventToState(LeadEvent event) async* {
    if (event is FetchLead) {
      yield LeadLoading();
//      var cache = await SharedPreferencesHelper.getListLead();

      try {
        LeadModel value = await _customerService.leadDMS(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield LeadFailed();
        } else {
          await SharedPreferencesHelper.setListLead(json.encode(value));

          yield LeadDisposeLoading();
          yield LeadSuccess(value);
        }

      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }

//      if (cache == null) {
//        log.info("Lead Cache Null Data");
//
//        try {
//          LeadModel value = await _customerService.leadDMS(event.value);
//
//          if (value.data.isEmpty || value.data == null) {
//            yield LeadFailed();
//          } else {
//            await SharedPreferencesHelper.setListLead(json.encode(value));
//
//            yield LeadDisposeLoading();
//            yield LeadSuccess(value);
//          }
//
//        } catch(error) {
//          log.warning("Error : ${error.toString()}");
//        }
//      } else {
//        log.info("Lead Cache on Data");
//        var cacheData = await SharedPreferencesHelper.getListLead();
//        log.info(cacheData);
//
//        LeadModel value = leadModelFromJson(cacheData);
//        yield LeadDisposeLoading();
//        yield LeadSuccess(value);
//      }
    }
  }
}