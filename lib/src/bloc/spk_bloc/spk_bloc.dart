import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_event.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_state.dart';
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

    if (event is FetchSpkNumber) {
      yield SpkLoading();

      SpkNumberModel value = await _spkService.spkNumberList();

      if (value.data.isEmpty || value.data == null) {
        yield SpkDisposeLoading();
        yield SpkFailed();
      } else {
        yield SpkDisposeLoading();
        yield SpkNumberSuccess(value);
      }
    }
  }

  bool _hasReachedMax(SpkState state) =>
      state is SpkSuccess && state.hasReachedMax;
}