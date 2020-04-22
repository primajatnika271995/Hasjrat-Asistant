import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_event.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_state.dart';
import 'package:salles_tools/src/models/customer_criteria_model.dart';
import 'package:salles_tools/src/models/leasing_model.dart';
import 'package:salles_tools/src/models/leasing_tenor_model.dart';
import 'package:salles_tools/src/models/province_model.dart';
import 'package:salles_tools/src/models/spk_model.dart' as spkModel;
import 'package:salles_tools/src/models/spk_number_model.dart';
import 'package:salles_tools/src/services/spk_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class SpkBloc extends Bloc<SpkEvent, SpkState> {
  SpkService _spkService;
  SpkBloc(this._spkService);

  @override
  // TODO: implement initialState
  SpkState get initialState => SpkInitial();

  @override
  Stream<SpkState> mapEventToState(SpkEvent event) async* {
    final currentState = state;

    if (event is FetchSpk && !_hasReachedMax(currentState)) {
      if (currentState is SpkInitial) {
        yield SpkLoading();

        try {
          spkModel.SpkModel value = await _spkService.spkList(event.value, "0", "20");
          List<spkModel.Datum> spk = value.data;

          yield SpkDisposeLoading();
          yield SpkSuccess(listSpk: spk, hasReachedMax: false);
        } catch(err) {
          log.warning("Error : ${err.toString()}");
          yield SpkError();
        }
      }

      if (currentState is SpkSuccess) {
        spkModel.SpkModel value = await _spkService.spkList(event.value, currentState.listSpk.length.toString(), "20");
        List<spkModel.Datum> spk = value.data;

        yield spk.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : SpkSuccess(listSpk: currentState.listSpk + spk, hasReachedMax: false);
      }
    }

    if (event is FetchSpkFilter) {
      yield SpkLoading();

      spkModel.SpkModel value = await _spkService.spkList(event.value, "", "");
      List<spkModel.Datum> spk = value.data;

      yield SpkDisposeLoading();
      yield SpkSuccess(
        hasReachedMax: true,
        listSpk: spk,
      );
    }

    if (event is RefreshSpk) {
      yield SpkLoading();

      spkModel.SpkModel value = await _spkService.spkList(event.value, "", "");
      List<spkModel.Datum> spk = value.data;

      yield SpkDisposeLoading();
      yield SpkSuccess(
        hasReachedMax: true,
        listSpk: spk,
      );
    }

    if (event is CreateSpk) {
      yield SpkLoading();

      try {
        await _spkService.createSpk(event.value);

        yield SpkDisposeLoading();
        yield CreateSpkSuccess();
      } catch (error) {
        yield SpkDisposeLoading();
        yield CreateSpkError();
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchSpkNumber) {
      yield SpkLoading();

      try {
        SpkNumberModel value = await _spkService.spkNumberList();

        if (value.data.isEmpty || value.data == null) {
          yield SpkDisposeLoading();
          yield SpkFailed();
        } else {
          yield SpkDisposeLoading();
          yield SpkNumberSuccess(value);
        }
      } catch (err) {
        log.warning("Error : ${err.toString()}");
        yield SpkError();
      }
    }

    if (event is FetchCustomerCriteria) {

      CustomerCriteriaModel value = await _spkService.customerCriteriaList();

      if (value.data.isEmpty || value.data == null) {
        yield SpkFailed();
      } else {
        yield CustomerCriteriaSuccess(value);
      }
    }

    if (event is FetchLeasing) {

      LeasingModel value = await _spkService.leasingList();

      if (value.data.isEmpty || value.data == null) {
        yield SpkFailed();
      } else {
        yield LeasingSuccess(value);
      }
    }

    if (event is FetchLeasingTenor) {
      LeasingTenorModel value = await _spkService.leasingTenorList();

      if (value.data.isEmpty || value.data == null) {
        yield SpkFailed();
      } else {
        yield LeasingTenorSuccess(value);
      }
    }

    if (event is FetchProvince) {
      try {
        ProvinceModel value = await _spkService.province();

        if (value.data.isEmpty || value.data == null) {
          yield SpkFailed();
        } else {
          yield ProvinceSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }
  }

  bool _hasReachedMax(SpkState state) =>
      state is SpkSuccess && state.hasReachedMax;
}