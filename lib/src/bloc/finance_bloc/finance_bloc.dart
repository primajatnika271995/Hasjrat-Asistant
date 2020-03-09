import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_event.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_state.dart';
import 'package:salles_tools/src/models/asset_kind_model.dart';
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
      yield FinanceLoading();

      try {
        BranchModel value = await _financeService.branchCode();
        yield FinanceDisposeLoading();
        yield BranchSuccess(value);

      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchAssetKind) {
      yield FinanceLoading();

      try {
        AssetKindModel value = await _financeService.assetKind(event.branchCode);
        yield FinanceDisposeLoading();
        yield AssetKindSuccess(value);

      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}
