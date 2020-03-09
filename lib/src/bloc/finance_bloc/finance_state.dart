import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/asset_kind_model.dart';
import 'package:salles_tools/src/models/branch_model.dart';

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