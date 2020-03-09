import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/asset_group_model.dart';
import 'package:salles_tools/src/models/asset_kind_model.dart';
import 'package:salles_tools/src/models/asset_type_model.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/models/insurance_type_model.dart';

class FinanceState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FinanceInitial extends FinanceState {}

class FinanceLoading extends FinanceState {}

class FinanceDisposeLoading extends FinanceState {}

class BranchFailed extends FinanceState {}

class BranchSuccess extends FinanceState {
  final _data;

  BranchSuccess(this._data);
  BranchModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class AssetKindFailed extends FinanceState {}

class AssetKindSuccess extends FinanceState {
  final _data;

  AssetKindSuccess(this._data);
  AssetKindModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class InsuranceTypeFailed extends FinanceState {}

class InsuranceTypeSuccess extends FinanceState {
  final _data;

  InsuranceTypeSuccess(this._data);
  InsuranceModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class AssetGroupFailed extends FinanceState {}

class AssetGroupSuccess extends FinanceState {
  final _data;

  AssetGroupSuccess(this._data);
  AssetGroupModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class AssetTypeFailed extends FinanceState {}

class AssetTypeSuccess extends FinanceState {
  final _data;

  AssetTypeSuccess(this._data);
  AssetTypeModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}