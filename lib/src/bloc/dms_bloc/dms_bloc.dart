import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/item_list_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
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
    if (event is FetchClass1Item) {
      yield DmsLoading();
      try {
        Class1ItemModel value = await _dmsService.class1();

        if (value.data.isEmpty || value.data == null) {
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

        if (value.data.isEmpty || value.data == null) {
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
  }
}