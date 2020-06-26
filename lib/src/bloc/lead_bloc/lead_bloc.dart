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
  Stream<LeadState> transformEvents(Stream<LeadEvent> events, Stream<LeadState> Function(LeadEvent) next) {
    // TODO: implement transformEvents
    return super.transformEvents(events, next);
  }

  @override
  // TODO: implement initialState
  LeadState get initialState => LeadInitial();

  @override
  Stream<LeadState> mapEventToState(LeadEvent event) async* {
    final currentState = state;

    if (event is FetchLead && !_hasReachedMax(currentState)) {
        if (currentState is LeadInitial) {
          yield LeadLoading();

          try {
            LeadModel value = await _customerService.leadDMS(event.value, "0", "20");
            List<Datum> leads = value.data;

            yield LeadDisposeLoading();
            yield LeadSuccess(
              leads: leads,
              hasReachedMax: false,
            );
          } catch(error) {
            log.warning("Error : ${error.toString()}");
            yield LeadError();
          }
        }

        if (currentState is LeadSuccess) {
          log.info("onSuccess");
          LeadModel value = await _customerService.leadDMS(event.value, currentState.leads.length.toString(), "20");
          List<Datum> leads = value.data;
          yield leads.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : LeadSuccess(
              leads: currentState.leads + leads, hasReachedMax: false);
        }
    }

    if (event is FetchLeadFilter) {
      yield LeadLoading();

      LeadModel value = await _customerService.leadDMS(event.value, "", "");
      List<Datum> leads = value.data;

      yield LeadDisposeLoading();
      yield LeadSuccess(
        leads: leads,
        hasReachedMax: true,
      );
    }

    if (event is RefreshLead) {
      yield LeadLoading();

      LeadModel value = await _customerService.leadDMS(event.value, "", "");
      List<Datum> leads = value.data;

      yield LeadDisposeLoading();
      yield LeadSuccess(
        leads: leads,
        hasReachedMax: true,
      );
    }

    if (event is FetchReminderLead) {
      yield LeadLoading();

      LeadModel value = await _customerService.leadDMS(event.value, "1", "100");
      List<Datum> leads = value.data;

      yield LeadDisposeLoading();
      yield LeadSuccess(
        leads: leads,
        hasReachedMax: true,
      );
    }
  }

  bool _hasReachedMax(LeadState state) =>
      state is LeadSuccess && state.hasReachedMax;
}