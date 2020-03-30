import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/sales_month_bloc/sales_month_event.dart';
import 'package:salles_tools/src/bloc/sales_month_bloc/sales_month_state.dart';
import 'package:salles_tools/src/models/sales_of_the_month_model.dart';
import 'package:salles_tools/src/services/sales_month_service.dart';

class SalesMonthBloc extends Bloc<SalesMonthEvent, SalesMonthState> {
  SalesMonthService _salesMonthService;
  SalesMonthBloc(this._salesMonthService);

  @override
  // TODO: implement initialState
  SalesMonthState get initialState => SalesMonthInitial();

  @override
  Stream<SalesMonthState> mapEventToState(SalesMonthEvent event) async* {
    if (event is FetchSalesMonth) {
      try {
        SalesOfTheMonthModel value = await _salesMonthService.lastSalesMonth(event.value);
        yield SalesMonthSuccess(value);
      } catch(err) {
        yield SalesMonthError();
      }
    }
  }
}