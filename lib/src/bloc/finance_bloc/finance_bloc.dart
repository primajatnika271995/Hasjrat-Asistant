import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_event.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_state.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/services/finance_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceService _financeService;
  FinanceBloc(this._financeService);

  @override
  // TODO: implement initialState
  FinanceState get initialState => FinanceInitial();

  @override
  Stream<FinanceState> mapEventToState(FinanceEvent event) async* {
    if (event is FetchBranch) {
      yield BranchLoading();

      try {
        BranchModel value = await _financeService.branchCode();
        yield BranchDisposeLoading();
        yield BranchSuccess(value);

      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}