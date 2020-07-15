import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/models/check_stock_model.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_event.dart';
import 'package:salles_tools/src/bloc/check_stock_bloc/check_stock_state.dart';
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
        CheckStockModel value = await _checkStockService.postCheckStock();
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
  }
}
