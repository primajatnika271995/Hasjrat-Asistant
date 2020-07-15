import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/models/check_stock_model.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_event.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_state.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import 'package:salles_tools/src/services/check_stock_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CheckStockBloc extends Bloc<CheckStockEvent, CheckStockState> {
  CheckStockService _checkStockService;
  CheckStockBloc(this._checkStockService);
  @override
  // TODO: implement initialState
  CheckStockState get initialState => CheckStockInitial();

  @override
  Stream<CheckStockState> mapEventToState(CheckStockEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchStockHo) {
      yield CheckStockLoading();

      try {
        CheckStockModel value = await _checkStockService.postCheckStock(event.value);
        if (value == null) {
          yield CheckStockFailed();
        } else {
          yield CheckStockDisposeLoading();
          yield CheckStockSuccess(value);
        }
      } catch (e) {
        log.warning("ERROR BLOC CHECK STOCK = ${e.toString()}");
        yield CheckStockLoading();
      }
    }

    //get branch cde
    if (event is FetchKodeBranch) {
      yield CheckStockLoading();
      try {
        BranchModel value = await _checkStockService.getBranchCode();
        if (value.result.isEmpty || value.result == null) {
          yield FetchKodeBranchFailed();
        } else {
          yield CheckStockDisposeLoading();
          yield FetchKodeBranchSukses(value);
        }
      } catch (e) {
        log.warning("ERROR BLOC GET BRANCH CODE : ${e.toString()}");
      }
    }

    //get list jenis kendaraan
    if (event is FetchJenisKendaraan) {
      yield CheckStockLoading();
      try {
        Class1ItemModel value = await _checkStockService.postJenisKendaraan();

        if (value.data.isEmpty || value.data == null) {
          yield CheckStockLoading();
          yield CheckStockFailed();
        } else {
          yield CheckStockDisposeLoading();
          yield FetchJenisKendaraanSukses(value);
        }
      } catch (e) {
        log.warning("ERROR BLOC FETCH JENIS KENDARAAN : ${e.toString()}");
      }
    }

    if (event is FetchModelKendaraan) {
      yield CheckStockLoading();
      try {
        ItemModel value =
            await _checkStockService.postModelKendaraan(event.value);
        if (value.data.isEmpty || value.data == null) {
          yield CheckStockLoading();
          yield FetchModelKendaraanFailed();
        } else {
          yield CheckStockDisposeLoading();
          yield FetchModelKendaraanSukses(value);
        }
      } catch (e) {
        log.warning("ERROR BLOC FETCH MODEL KENDARAAN : ${e.toString()}");
      }
    }

    if (event is FetchTipeKendaraan) {
      yield CheckStockLoading();
      try {
        ItemModel value =
            await _checkStockService.postModelKendaraan(event.value);
        if (value.data.isEmpty || value.data == null) {
          yield CheckStockLoading();
          yield FetchTipeKendaraanFailed();
        } else {
          yield CheckStockDisposeLoading();
          yield FetchTipeKendaraanSukses(value);
        }
      } catch (e) {
        log.warning("ERROR BLOC FETCH TIPE KENDARAAN : ${e.toString()}");
      }
    }

    if (event is FetchKodeKendaraan) {
      yield CheckStockLoading();
      try {
        PriceListModel value =
            await _checkStockService.postKodeKendaraan(event.value);
        if (value.data.isEmpty || value.data == null) {
          yield CheckStockLoading();
          yield FetchKodeKendaraanFailed();
        } else {
          yield CheckStockDisposeLoading();
          yield FetchKodeKendaraanSukses(value);
        }
      } catch (e) {
        log.warning("ERROR BLOC FETCH KODE KENDARAAN : ${e.toString()}");
      }
    }
  }
}
