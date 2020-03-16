import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
import 'package:salles_tools/src/models/location_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerService _customerService;
  CustomerBloc(this._customerService);

  @override
  // TODO: implement initialState
  CustomerState get initialState => CustomerInitial();

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {
    if (event is FetchCustomer) {
      yield CustomerLoading();
      var cache = await SharedPreferencesHelper.getListCustomer();

      if (cache == null) {
        log.info("Customer Cache Null Data");

        try {
          CustomerModel value = await _customerService.customerDMS(event.value);

          if (value.data.isEmpty || value.data == null) {
            yield CustomerFailed();
          } else {
            await SharedPreferencesHelper.setListCustomer(json.encode(value));

            yield CustomerDisposeLoading();
            yield CustomerSuccess(value);
          }

        } catch(error) {
          log.warning("Error : ${error.toString()}");
          CustomerError valError = await _customerService.customerDMS(event.value);
          CustomerError(valError);
        }
      } else {
        log.info("Customer Cache on Data");
        var cacheData = await SharedPreferencesHelper.getListCustomer();
        log.info(cacheData);

        CustomerModel value = customerModelFromJson(cacheData);
        yield CustomerDisposeLoading();
        yield CustomerSuccess(value);
      }
    }

    if (event is FetchGender) {
      yield CustomerLoading();

      try {
        GenderModel value = await _customerService.gender(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield CustomerDisposeLoading();
          yield CustomerGender(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchLocation) {
      yield CustomerLoading();

      try {
        LocationModel value = await _customerService.location(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield CustomerDisposeLoading();
          yield CustomerLocation(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchJob) {
      yield CustomerLoading();

      try {
        JobModel value = await _customerService.job(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield CustomerDisposeLoading();
          yield CustomerJob(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}