import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_event.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_state.dart';
import 'package:salles_tools/src/models/asset_group_model.dart';
import 'package:salles_tools/src/models/asset_kind_model.dart';
import 'package:salles_tools/src/models/asset_price_model.dart';
import 'package:salles_tools/src/models/asset_type_model.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/models/insurance_type_model.dart';
import 'package:salles_tools/src/models/outlet_model.dart';
import 'package:salles_tools/src/models/simulation_model.dart';
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

    if (event is FetchOutlet) {
      yield FinanceLoading();

      try {
        OutletModel value = await _financeService.outletCode(event.branchCode);
        yield FinanceDisposeLoading();
        yield OutletSuccess(value);

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

    if (event is FetchInsuranceType) {
      yield FinanceLoading();

      try {
        InsuranceModel value = await _financeService.insuranceType(event.branchCode, event.assetKindCode);
        yield FinanceDisposeLoading();
        yield InsuranceTypeSuccess(value);

      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchAssetGroup) {
      yield FinanceLoading();

      try {
        AssetGroupModel value = await _financeService.assetGroup(event.branchCode, event.assetKindCode, event.insuranceAssetCode);
        yield FinanceDisposeLoading();
        yield AssetGroupSuccess(value);

      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchAssetType) {
      yield FinanceLoading();

      try {
        AssetTypeModel value = await _financeService.assetType(event.branchCode, event.assetKindCode, event.insuranceAssetCode, event.assetGroupCode);
        yield FinanceDisposeLoading();
        yield AssetTypeSuccess(value);

      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchAssetPrice) {
      yield FinanceLoading();

      try {
        AssetPriceModel value = await _financeService.assetPrice(event.branchCode, event.assetKindCode, event.insuranceAssetCode, event.assetGroupCode, event.assetTypeCode);
        log.info(value);

        if (value.result != null) {
          yield FinanceDisposeLoading();
          yield AssetPriceSuccess(value);
        } else {
          yield FinanceDisposeLoading();
          yield AssetPriceFailed();
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchSimulationDownPayment) {
      yield FinanceLoading();

      try {
        SimulationModel value = await _financeService.simulationDownPayment(event.branchCode, event.assetKindCode, event.insuranceAssetCode, event.assetGroupCode, event.assetTypeCode, event.priceListId, event.price, event.downPayment);
        log.info(value);

        if (value.result != null) {
          yield FinanceDisposeLoading();
          yield SimulationSuccess(value);
        } else {
          log.warning("Simulation Failed");
          yield FinanceDisposeLoading();
          yield SimulationFailed();
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchSimulationPriceList) {
      yield FinanceLoading();

      try {
        SimulationModel value = await _financeService.simulationPriceList(event.branchCode, event.assetKindCode, event.insuranceAssetCode, event.assetGroupCode, event.assetTypeCode, event.priceListId, event.price);
        log.info(value);

        if (value.result != null) {
          yield FinanceDisposeLoading();
          yield SimulationSuccess(value);
        } else {
          yield FinanceDisposeLoading();
          yield SimulationFailed();
        }
      } catch (error) {
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}
