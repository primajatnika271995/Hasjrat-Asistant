import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/item_list_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import 'package:salles_tools/src/models/program_penjualan_model.dart';
import 'package:salles_tools/src/models/prospect_model.dart' as prospect;
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class DmsBloc extends Bloc<DmsEvent, DmsState> {
  DmsService _dmsService;
  DmsBloc(this._dmsService);

  @override
  // TODO: implement initialState
  DmsState get initialState => DmsInitial();

  @override
  Stream<DmsState> mapEventToState(DmsEvent event) async* {
    final currentState = state;

    if (event is FetchProspect && !_hasReachedMax(currentState)) {
      if (currentState is DmsInitial) {
        yield DmsLoading();

        try {
          prospect.ProspectModel value = await _dmsService.prospectDMS(event.value, "0", "20");
          List<prospect.Datum> prospects = value.data;

          yield DmsDisposeLoading();
          yield ProspectSuccess(prospects: prospects, hasReachedMax: false,
          );
        } catch (err) {
          yield DmsError();
        }
      }

      if (currentState is ProspectSuccess) {
        log.info("onSuccess");
        prospect.ProspectModel value = await _dmsService.prospectDMS(event.value, currentState.prospects.length.toString(), "20");
        List<prospect.Datum> prospects = value.data;
        yield prospects.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : ProspectSuccess(
                prospects: currentState.prospects + prospects,
                hasReachedMax: false,
        );
      }
    }

    if (event is FetchProspectFilter) {
      yield DmsLoading();

      prospect.ProspectModel value = await _dmsService.prospectDMS(event.value, "", "");
      List<prospect.Datum> prospects = value.data;

      yield DmsDisposeLoading();
      yield ProspectSuccess(
        prospects: prospects,
        hasReachedMax: true,
      );
    }

    if (event is RefreshProspect) {
      yield DmsLoading();

      prospect.ProspectModel value = await _dmsService.prospectDMS(event.value, "", "");
      List<prospect.Datum> prospects = value.data;

      yield DmsDisposeLoading();
      yield ProspectSuccess(
        prospects: prospects,
        hasReachedMax: true,
      );
    }

    if (event is FetchClass1Item) {
      yield DmsLoading();
      try {
        Class1ItemModel value = await _dmsService.class1();

        if (value.data.isEmpty || value.data == null) {
          yield DmsDisposeLoading();
          yield DmsFailed();
        } else {
          yield DmsDisposeLoading();
          yield Class1ItemSuccess(value);
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchItemModel) {
      yield DmsLoading();
      try {
        ItemModel value = await _dmsService.itemModel(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield DmsDisposeLoading();
          yield DmsFailed();
        } else {
          yield DmsDisposeLoading();
          yield ItemModelSuccess(value);
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchItemType) {
      yield DmsLoading();
      try {
        ItemModel value = await _dmsService.itemModel(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield DmsDisposeLoading();
          yield DmsFailed();
        } else {
          yield DmsDisposeLoading();
          yield ItemTypeSuccess(value);
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchPriceList) {
      yield DmsLoading();
      try {
        PriceListModel value = await _dmsService.priceList(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield DmsFailed();
        } else {
          yield DmsDisposeLoading();
          yield PriceListSuccess(value);
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchItemList) {
      yield DmsLoading();
      try {
        ItemListModel value = await _dmsService.itemList(event.value);

        if (value.data.isEmpty || value.data == null || value.data[0].pricelists.isEmpty || value.data[0].pricelists == null) {
          yield ItemListFailed();
        } else {
          yield DmsDisposeLoading();
          yield ItemListSuccess(value);
        }
      } catch (error) {
        yield ItemListFailed();
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is CreateProspect) {
      yield DmsLoading();

      try {
        await _dmsService.createProspect(event.value);

        yield DmsDisposeLoading();
        yield CreateProspectSuccess();
      } catch (error) {
        yield DmsDisposeLoading();
        yield CreateProspectError();
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchProgramPenjualan) {
      yield DmsLoading();

      try {
        ProgramPenjualanModel value =
            await _dmsService.fetchListProgramPenjualan(event.value);
        if (value.data.isEmpty) {
          yield ListProgramPenjualanError();
        } else {
          yield DmsDisposeLoading();
          yield ListProgramPenjualanSuccess(value);
        }
      } catch (e) {
        log.warning("Error : ${e.toString()}");
        yield ListProgramPenjualanError();
      }
    }
  }

  bool _hasReachedMax(DmsState state) =>
      state is ProspectSuccess && state.hasReachedMax;
}
