import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/class1_item_model.dart';
import 'package:salles_tools/src/models/item_model.dart';
import 'package:salles_tools/src/models/price_list_model.dart';
import 'package:salles_tools/src/models/branch_model.dart';
import 'package:salles_tools/src/models/check_stock_model.dart';
import 'package:salles_tools/src/models/branch_stock_model.dart';

class CheckStockState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckStockInitial extends CheckStockState {}

class CheckStockLoading extends CheckStockState {}

class CheckStockDisposeLoading extends CheckStockState {}

class CheckStockFailed extends CheckStockState {}

class CheckStockSuccess extends CheckStockState {
  final _data;

  CheckStockSuccess(this._data);
  CheckStockModel get value => _data;
  @override
  List<Object> get props => [_data];
}

class FetchKodeBranchSukses extends CheckStockState {
  final _data;

  FetchKodeBranchSukses(this._data);
  List<BranchStockModel> get value => _data;

  @override
  List<Object> get props => _data;
}

class FetchKodeBranchFailed extends CheckStockState {}

class FetchJenisKendaraanSukses extends CheckStockState {
  final _data;

  FetchJenisKendaraanSukses(this._data);
  Class1ItemModel get value => _data;

  @override
  List<Object> get props => [_data];
}

class FetchJenisKendaraanFailed extends CheckStockState {}

class FetchModelKendaraanSukses extends CheckStockState {
  final _data;

  FetchModelKendaraanSukses(this._data);
  ItemModel get value => _data;
  @override
  List<Object> get props => [_data];
}

class FetchModelKendaraanFailed extends CheckStockState {}

class FetchTipeKendaraanSukses extends CheckStockState {
  final _data;

  FetchTipeKendaraanSukses(this._data);
  ItemModel get value => _data;
  @override
  List<Object> get props => [_data];
}

class FetchTipeKendaraanFailed extends CheckStockState {}

class FetchKodeKendaraanSukses extends CheckStockState {
  final _data;

  FetchKodeKendaraanSukses(this._data);
  PriceListModel get value => _data;

  @override
  List<Object> get props => _data;
}

class FetchKodeKendaraanFailed extends CheckStockState {}
