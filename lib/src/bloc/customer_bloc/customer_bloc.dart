import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/district_model.dart';
import 'package:salles_tools/src/models/gender_model.dart';
import 'package:salles_tools/src/models/job_model.dart';
import 'package:salles_tools/src/models/location_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
import 'package:salles_tools/src/models/sub_district_model.dart';
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
          yield GenderSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchLocation) {
      try {
        LocationModel value = await _customerService.location(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield LocationSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchJob) {
      try {
        JobModel value = await _customerService.job(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield JobSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchProvince) {
      try {
        ProvinceModel value = await _customerService.province();

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield ProvinceSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchDistrict) {
      yield CustomerLoading();

      try {
        DistrictModel value = await _customerService.district(event.provinceCode);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerDisposeLoading();
          yield CustomerFailed();
        } else {
          yield CustomerDisposeLoading();
          yield DistrictSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchSubDistrict) {
      yield CustomerLoading();

      try {
        SubDistrictModel value = await _customerService.subDistrict(event.provinceCode, event.districtCode);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerDisposeLoading();
          yield CustomerFailed();
        } else {
          yield CustomerDisposeLoading();
          yield SubDistrictSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is CreateContact) {
      yield CustomerLoading();

      try {
        await _customerService.createLead(event.value);

        yield CustomerDisposeLoading();
        yield CreateContactSuccess();
      } catch(error) {
        yield CustomerDisposeLoading();
        yield CreateContactError();
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is CreateProspect) {
      yield CustomerLoading();

      try {
        await _customerService.createProspect(event.value);

        yield CustomerDisposeLoading();
        yield CreateProspectSuccess();
      } catch(error) {
        yield CustomerDisposeLoading();
        yield CreateProspectError();
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}